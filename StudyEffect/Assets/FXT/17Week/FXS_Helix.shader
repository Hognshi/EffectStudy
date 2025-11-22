// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/16week/FX_Helix"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Main_Power("Main_Power", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
		_MaskTex("MaskTex", 2D) = "white" {}
		_Opacity_Power("Opacity_Power", Float) = 1
		_Opacity_Ins("Opacity_Ins", Float) = 1
		_NormalTex("NormalTex", 2D) = "bump" {}
		_Normal_Upanner("Normal_Upanner", Float) = 0
		_Normal_Vpanner("Normal_Vpanner", Float) = 0
		_Distortion("Distortion", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _MainTex;
		uniform sampler2D _NormalTex;
		uniform float _Normal_Upanner;
		uniform float _Normal_Vpanner;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float4 _MainTex_ST;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform sampler2D _MaskTex;
		uniform float4 _MaskTex_ST;
		uniform float _Opacity_Power;
		uniform float _Opacity_Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult24 = (float2(_Normal_Upanner , _Normal_Vpanner));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner23 = ( 1.0 * _Time.y * appendResult24 + uv0_NormalTex);
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 appendResult4 = (float2(( i.uv_tex4coord.z + uv0_MainTex.y ) , uv0_MainTex.x));
			float4 tex2DNode2 = tex2D( _MainTex, ( ( (UnpackNormal( tex2D( _NormalTex, panner23 ) )).xy * _Distortion ) + appendResult4 ) );
			o.Emission = ( ( pow( tex2DNode2.r , _Main_Power ) * _Main_Ins ) * i.vertexColor ).rgb;
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * saturate( ( saturate( pow( ( tex2DNode2.r * tex2D( _MaskTex, uv_MaskTex ).r ) , _Opacity_Power ) ) * _Opacity_Ins ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
623;392;1830;1152;809.8841;449.7582;1.329614;True;False
Node;AmplifyShaderEditor.RangedFloatNode;26;-1832.605,-453.075;Float;False;Property;_Normal_Vpanner;Normal_Vpanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1835.605,-533.075;Float;False;Property;_Normal_Upanner;Normal_Upanner;8;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1684.605,-743.075;Float;False;0;21;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;24;-1599.605,-526.075;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-1424.605,-614.075;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;21;-1215.605,-644.075;Float;True;Property;_NormalTex;NormalTex;7;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;31;-969.7079,-348.8153;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-952.337,-106.0489;Float;True;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-694.2826,-181.0495;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;27;-869.3288,-645.8362;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-852.8025,-436.1932;Float;False;Property;_Distortion;Distortion;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-475.8025,-458.1932;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-469.2826,-75.04956;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-328.8025,-254.1932;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;12;-261.2981,384.0102;Float;True;Property;_MaskTex;MaskTex;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-181.5,-104.5;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;130.6054,386.8422;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;157.7104,626.457;Float;False;Property;_Opacity_Power;Opacity_Power;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;361.4342,386.4406;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;523.3864,626.9993;Float;False;Property;_Opacity_Ins;Opacity_Ins;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;19;524.2408,387.6434;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;142.4273,80.14993;Float;False;Property;_Main_Power;Main_Power;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;6;297.011,-77.01276;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;695.0845,388.1679;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;359.2185,97.38464;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;11;726.4169,98.30686;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;20;840.2599,316.1193;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;536.2184,-75.45906;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;980.7139,191.8589;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;960.8591,-76.93235;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1147.893,-80.04214;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/16week/FX_Helix;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;25;0
WireConnection;24;1;26;0
WireConnection;23;0;22;0
WireConnection;23;2;24;0
WireConnection;21;1;23;0
WireConnection;3;0;31;3
WireConnection;3;1;1;2
WireConnection;27;0;21;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;4;0;3;0
WireConnection;4;1;1;1
WireConnection;30;0;28;0
WireConnection;30;1;4;0
WireConnection;2;1;30;0
WireConnection;13;0;2;1
WireConnection;13;1;12;1
WireConnection;16;0;13;0
WireConnection;16;1;18;0
WireConnection;19;0;16;0
WireConnection;6;0;2;1
WireConnection;6;1;8;0
WireConnection;17;0;19;0
WireConnection;17;1;15;0
WireConnection;20;0;17;0
WireConnection;7;0;6;0
WireConnection;7;1;9;0
WireConnection;14;0;11;4
WireConnection;14;1;20;0
WireConnection;10;0;7;0
WireConnection;10;1;11;0
WireConnection;0;2;10;0
WireConnection;0;9;14;0
ASEEND*/
//CHKSM=A12E2210102BF0F9CC22F67918F6B57FADB7DD88