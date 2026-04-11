// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "m"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_Main_power("Main_power", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
		_MaskTex("MaskTex", 2D) = "white" {}
		_OpacityPower("OpacityPower", Float) = 1
		_OpacityIns("OpacityIns", Float) = 1
		_NormalTex("NormalTex", 2D) = "white" {}
		_NormalUPanner("NormalUPanner", Float) = 0
		_NormalVPanner("NormalVPanner", Float) = 0
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
		uniform float _NormalUPanner;
		uniform float _NormalVPanner;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float4 _MainTex_ST;
		uniform float _Main_power;
		uniform float _Main_Ins;
		uniform sampler2D _MaskTex;
		uniform float4 _MaskTex_ST;
		uniform float _OpacityPower;
		uniform float _OpacityIns;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult25 = (float2(_NormalUPanner , _NormalVPanner));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner24 = ( 1.0 * _Time.y * appendResult25 + uv0_NormalTex);
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 appendResult4 = (float2(( i.uv_tex4coord.z + uv0_MainTex.x ) , uv0_MainTex.y));
			float4 tex2DNode2 = tex2D( _MainTex, ( ( (tex2D( _NormalTex, panner24 )).rga * _Distortion ) + float3( appendResult4 ,  0.0 ) ).xy );
			o.Emission = ( ( pow( tex2DNode2.r , _Main_power ) * _Main_Ins ) * i.vertexColor ).rgb;
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * saturate( ( saturate( pow( ( tex2DNode2.r * tex2D( _MaskTex, uv_MaskTex ).r ) , _OpacityPower ) ) * _OpacityIns ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
527;473;1498;975;2144.458;740.1358;2.509118;True;False
Node;AmplifyShaderEditor.RangedFloatNode;26;-2249.13,-160.1314;Float;False;Property;_NormalUPanner;NormalUPanner;8;0;Create;True;0;0;False;0;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2250.13,-77.13135;Float;False;Property;_NormalVPanner;NormalVPanner;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-2009.131,-160.1314;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-2086.131,-335.1314;Float;False;0;22;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;24;-1825.131,-335.1314;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;22;-1594.618,-345.5684;Float;True;Property;_NormalTex;NormalTex;7;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;721fbf961ddca074d8e6f773e3caa157;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;34;-1757.461,-86.52051;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1818.272,209.2392;Float;True;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-1522.159,84.59797;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1109.02,-90.58569;Float;False;Property;_Distortion;Distortion;10;0;Create;True;0;0;False;0;0;0.342;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;28;-1208.536,-344.8317;Float;True;True;True;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-1397.159,242.598;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-875.02,-273.8858;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-823.0203,1.714283;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;2;-657.8713,64.33914;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;635746eb8ef36ac4a9f6ae8c0ae35b46;635746eb8ef36ac4a9f6ae8c0ae35b46;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-849.7583,426.298;Float;True;Property;_MaskTex;MaskTex;4;0;Create;True;0;0;False;0;cbd7928b57efc0c42a25214f11fd8ac5;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-249.8378,668.4388;Float;False;Property;_OpacityPower;OpacityPower;5;0;Create;True;0;0;False;0;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-236.958,429.498;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;17;-90.83794,505.4389;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-38.83794,668.4388;Float;False;Property;_OpacityIns;OpacityIns;6;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-312.9585,263.498;Float;False;Property;_Main_power;Main_power;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;63.17052,512.6199;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;6;-153.9585,100.498;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;227.1968,513.0767;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-101.9585,263.498;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;43.0415,96.49796;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;12;44.0415,308.498;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;21;371.5761,512.6194;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;512.6024,475.1532;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;271.0415,96.49796;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;490,19;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;m;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;26;0
WireConnection;25;1;27;0
WireConnection;24;0;23;0
WireConnection;24;2;25;0
WireConnection;22;1;24;0
WireConnection;3;0;34;3
WireConnection;3;1;1;1
WireConnection;28;0;22;0
WireConnection;4;0;3;0
WireConnection;4;1;1;2
WireConnection;29;0;28;0
WireConnection;29;1;30;0
WireConnection;31;0;29;0
WireConnection;31;1;4;0
WireConnection;2;1;31;0
WireConnection;14;0;2;1
WireConnection;14;1;13;1
WireConnection;17;0;14;0
WireConnection;17;1;16;0
WireConnection;20;0;17;0
WireConnection;6;0;2;1
WireConnection;6;1;9;0
WireConnection;19;0;20;0
WireConnection;19;1;18;0
WireConnection;7;0;6;0
WireConnection;7;1;10;0
WireConnection;21;0;19;0
WireConnection;15;0;12;4
WireConnection;15;1;21;0
WireConnection;11;0;7;0
WireConnection;11;1;12;0
WireConnection;0;2;11;0
WireConnection;0;9;15;0
ASEEND*/
//CHKSM=0465034DE2A422318C8DA6249AFD3A5C2691D28E