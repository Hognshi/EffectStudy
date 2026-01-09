// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/26week/FX_WaterWave"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_MaskTex("MaskTex", 2D) = "white" {}
		_NormalTex("NormalTex", 2D) = "bump" {}
		_Distortion("Distortion", Range( 0 , 1)) = 0
		_Normal_Upanner("Normal_Upanner", Float) = 0
		_Normal_Vpanner("Normal_Vpanner", Float) = 0
		[HDR]_Color_A("Color_A", Color) = (0,0,0,0)
		[HDR]_Color_B("Color_B", Color) = (0,0,0,0)
		_Color_Offset("Color_Offset", Float) = 0
		_Color_Range("Color_Range", Float) = 0
		_Opacity("Opacity", Float) = 0
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

		uniform float4 _Color_A;
		uniform float4 _Color_B;
		uniform sampler2D _MainTex;
		uniform sampler2D _NormalTex;
		uniform float _Normal_Upanner;
		uniform float _Normal_Vpanner;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float4 _MainTex_ST;
		uniform float _Color_Offset;
		uniform float _Color_Range;
		uniform sampler2D _MaskTex;
		uniform float4 _MaskTex_ST;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult13 = (float2(_Normal_Upanner , _Normal_Vpanner));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner12 = ( 1.0 * _Time.y * appendResult13 + uv0_NormalTex);
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 appendResult5 = (float2(uv0_MainTex.x , ( uv0_MainTex.y + i.uv_tex4coord.z )));
			float4 tex2DNode1 = tex2D( _MainTex, ( ( (UnpackNormal( tex2D( _NormalTex, panner12 ) )).xy * _Distortion ) + appendResult5 ) );
			float4 lerpResult23 = lerp( _Color_A , _Color_B , saturate( ( saturate( pow( tex2DNode1.r , _Color_Offset ) ) * _Color_Range ) ));
			o.Emission = ( lerpResult23 * i.vertexColor ).rgb;
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * saturate( ( ( tex2DNode1.r * tex2D( _MaskTex, uv_MaskTex ).r ) * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
479;491;1081;648;1936.562;1058.412;1.9;False;False
Node;AmplifyShaderEditor.RangedFloatNode;14;-1853.894,-455.9369;Float;False;Property;_Normal_Upanner;Normal_Upanner;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1854.894,-366.9369;Float;False;Property;_Normal_Vpanner;Normal_Vpanner;6;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-1593.894,-451.9369;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1665.894,-631.9369;Float;False;0;7;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;12;-1422.894,-572.9369;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;7;-1214.894,-592.9369;Float;True;Property;_NormalTex;NormalTex;3;0;Create;True;0;0;False;0;None;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-940.894,-142.9369;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;17;-925.9896,47.85847;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-707.894,-47.93692;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;8;-896.894,-592.9369;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-928.894,-483.9369;Float;False;Property;_Distortion;Distortion;4;0;Create;True;0;0;False;0;0;0.129;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;5;-524.894,-113.9369;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-642.894,-589.9369;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-374.894,-286.9369;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-207.5,-147;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;f139b90715b6fcb4f9eb2456510bc56b;c9b11ee819df03644a5ef6cb895608a1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;26;19.20197,-312.1037;Float;False;Property;_Color_Offset;Color_Offset;9;0;Create;True;0;0;False;0;0;2.66;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;18;194.6012,-331.2246;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;371.9114,-333.6873;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-184.3122,399.2189;Float;True;Property;_MaskTex;MaskTex;2;0;Create;True;0;0;False;0;None;f139b90715b6fcb4f9eb2456510bc56b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;354.202,-429.1037;Float;False;Property;_Color_Range;Color_Range;10;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;500.2089,387.7818;Float;False;Property;_Opacity;Opacity;11;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;169.4302,265.5477;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;520.9011,-333.6873;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;597.1539,-724.1801;Float;False;Property;_Color_A;Color_A;7;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.1183373,0.1855373,0.6431373,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;25;599.6166,-529.6315;Float;False;Property;_Color_B;Color_B;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.8235294,1.098039,1.498039,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;666.609,269.4818;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;671.1222,-336.15;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;23;885.2831,-548.1011;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;29;939.6088,-111.4181;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;32;855.1091,269.4817;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1208.709,-238.8182;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;1169.709,129.0818;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1389.026,-66.03722;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS/26week/FX_WaterWave;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;14;0
WireConnection;13;1;15;0
WireConnection;12;0;11;0
WireConnection;12;2;13;0
WireConnection;7;1;12;0
WireConnection;4;0;3;2
WireConnection;4;1;17;3
WireConnection;8;0;7;0
WireConnection;5;0;3;1
WireConnection;5;1;4;0
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;6;0;9;0
WireConnection;6;1;5;0
WireConnection;1;1;6;0
WireConnection;18;0;1;1
WireConnection;18;1;26;0
WireConnection;20;0;18;0
WireConnection;16;0;1;1
WireConnection;16;1;2;1
WireConnection;21;0;20;0
WireConnection;21;1;27;0
WireConnection;30;0;16;0
WireConnection;30;1;31;0
WireConnection;22;0;21;0
WireConnection;23;0;24;0
WireConnection;23;1;25;0
WireConnection;23;2;22;0
WireConnection;32;0;30;0
WireConnection;28;0;23;0
WireConnection;28;1;29;0
WireConnection;33;0;29;4
WireConnection;33;1;32;0
WireConnection;0;2;28;0
WireConnection;0;9;33;0
ASEEND*/
//CHKSM=9A84D2B13875E5D321DC3C1EFC8BB5E71435848C