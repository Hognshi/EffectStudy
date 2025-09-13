// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/10Week/Homework/FX_Slash"
{
	Properties
	{
		_FXT_Slash("FXT_Slash", 2D) = "white" {}
		_DissolveUp("DissolveUp", Float) = 0
		_DissolveVP("DissolveVP", Float) = 0
		_T_Noise_05("T_Noise_05", 2D) = "white" {}
		_MainPower("MainPower", Float) = 1
		_MainIns("MainIns", Float) = 1
		[HDR]_MainColor("MainColor", Color) = (1,1,1,0)
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _FXT_Slash;
		uniform float4 _FXT_Slash_ST;
		uniform sampler2D _T_Noise_05;
		uniform float _DissolveUp;
		uniform float _DissolveVP;
		uniform float _MainPower;
		uniform float _MainIns;
		uniform float4 _MainColor;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_FXT_Slash = i.uv_texcoord * _FXT_Slash_ST.xy + _FXT_Slash_ST.zw;
			float2 temp_cast_0 = (( _DissolveUp + _DissolveVP )).xx;
			float2 panner6 = ( 1.0 * _Time.y * temp_cast_0 + i.uv_texcoord);
			o.Emission = ( ( pow( ( tex2D( _FXT_Slash, uv_FXT_Slash ).r * saturate( ( tex2D( _T_Noise_05, panner6 ).r + i.uv_tex4coord.z ) ) ) , _MainPower ) * _MainIns * _MainColor ) * i.vertexColor ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
93.6;157.6;1280;644;2753.04;1548.303;4.571517;True;True
Node;AmplifyShaderEditor.RangedFloatNode;8;-1236.781,374.9527;Float;False;Property;_DissolveVP;DissolveVP;3;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1235.276,281.0688;Float;False;Property;_DissolveUp;DissolveUp;2;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1234.865,145.8429;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-1051.561,310.6981;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;6;-1024.865,145.8429;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-819.0596,137.3383;Float;True;Property;_T_Noise_05;T_Noise_05;4;0;Create;True;0;0;False;0;38adc42de31c1464abdb28ac941294df;38adc42de31c1464abdb28ac941294df;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;13;-749.2062,419.5825;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-423.8663,173.2201;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-828.0443,-97.82192;Float;True;Property;_FXT_Slash;FXT_Slash;1;0;Create;True;0;0;False;0;79ed8cb926ef9614caf3aacd7eb86e35;79ed8cb926ef9614caf3aacd7eb86e35;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;14;-206.1321,161.8822;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-130.1321,-54.11781;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;87.70929,144.0299;Float;False;Property;_MainPower;MainPower;5;0;Create;True;0;0;False;0;1;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;391.8079,164.9304;Float;False;Property;_MainIns;MainIns;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;16;283.8679,-35.1178;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;323.8079,-288.0696;Float;False;Property;_MainColor;MainColor;7;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.5283018,0,0.7924528,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;733.8079,-32.06958;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;23;683.7153,179.8331;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;869.8079,-19.06958;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1024.3,-82.50001;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS/10Week/Homework/FX_Slash;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;7;0
WireConnection;9;1;8;0
WireConnection;6;0;4;0
WireConnection;6;2;9;0
WireConnection;11;1;6;0
WireConnection;12;0;11;1
WireConnection;12;1;13;3
WireConnection;14;0;12;0
WireConnection;15;0;1;1
WireConnection;15;1;14;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;20;0;16;0
WireConnection;20;1;19;0
WireConnection;20;2;21;0
WireConnection;22;0;20;0
WireConnection;22;1;23;0
WireConnection;0;2;22;0
WireConnection;0;9;23;4
ASEEND*/
//CHKSM=C0A2F7BE841E8A406E861F317CB8E7D06C147DC6