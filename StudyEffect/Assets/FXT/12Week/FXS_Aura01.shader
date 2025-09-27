// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/12Week/FXT_Aura_01"
{
	Properties
	{
		_FXT_Aura("FXT_Aura", 2D) = "white" {}
		_Noise("Noise", 2D) = "white" {}
		_Noise_U("Noise_U", Float) = 1
		_Noise_V("Noise_V", Float) = 1
		_Main_power("Main_power", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
		[HDR]_Main_color("Main_color", Color) = (1,1,1,0)
		_Opacity("Opacity", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
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

		uniform sampler2D _Noise;
		uniform float _Noise_U;
		uniform float _Noise_V;
		uniform sampler2D _FXT_Aura;
		uniform float4 _FXT_Aura_ST;
		uniform float _Main_power;
		uniform float _Main_Ins;
		uniform float4 _Main_color;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult12 = (float2(_Noise_U , _Noise_V));
			float2 panner9 = ( 1.0 * _Time.y * appendResult12 + i.uv_texcoord);
			float2 uv_FXT_Aura = i.uv_texcoord * _FXT_Aura_ST.xy + _FXT_Aura_ST.zw;
			float temp_output_15_0 = saturate( ( ( tex2D( _Noise, panner9 ).r + i.uv_tex4coord.z ) * tex2D( _FXT_Aura, uv_FXT_Aura ).r ) );
			o.Emission = ( ( pow( temp_output_15_0 , _Main_power ) * _Main_Ins * _Main_color ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( ( temp_output_15_0 * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1536;0;1280;739;1859.507;1169.109;2.471778;True;True
Node;AmplifyShaderEditor.RangedFloatNode;14;-1067.258,97.53289;Float;False;Property;_Noise_V;Noise_V;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1070.927,-47.41121;Float;False;Property;_Noise_U;Noise_U;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;12;-681.9633,14.96982;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-832.411,-179.5121;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;9;-573.7137,-185.0163;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;27;-248.6347,-77.21606;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-339,-296.5;Float;True;Property;_Noise;Noise;2;0;Create;True;0;0;False;0;3c1b02a85ac349f4f9375a88a9fa62e6;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-324.9915,172.206;Float;True;Property;_FXT_Aura;FXT_Aura;1;0;Create;True;0;0;False;0;abf04ffd092e1f449b26c48c7d7e4a1e;abf04ffd092e1f449b26c48c7d7e4a1e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;5;34.99342,-272.6713;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;280.5575,-100.6104;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;391.647,451.5779;Float;False;Property;_Opacity;Opacity;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;15;418.8786,-106.1229;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;474.2863,-229.858;Float;False;Property;_Main_power;Main_power;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;541.5079,368.084;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;537.7161,79.92017;Float;False;Property;_Main_color;Main_color;7;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;16;587.6743,-104.2881;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;695.2585,-221.1536;Float;False;Property;_Main_Ins;Main_Ins;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;21;844.4666,85.74006;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;25;740.4146,328.0841;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;806.3263,-116.1715;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;1023.735,2.232361;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;992.6146,296.8841;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1199.895,-196.8345;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS/12Week/FXT_Aura_01;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;13;0
WireConnection;12;1;14;0
WireConnection;9;0;8;0
WireConnection;9;2;12;0
WireConnection;4;1;9;0
WireConnection;5;0;4;1
WireConnection;5;1;27;3
WireConnection;6;0;5;0
WireConnection;6;1;3;1
WireConnection;15;0;6;0
WireConnection;23;0;15;0
WireConnection;23;1;24;0
WireConnection;16;0;15;0
WireConnection;16;1;18;0
WireConnection;25;0;23;0
WireConnection;17;0;16;0
WireConnection;17;1;19;0
WireConnection;17;2;20;0
WireConnection;22;0;17;0
WireConnection;22;1;21;0
WireConnection;26;0;21;4
WireConnection;26;1;25;0
WireConnection;0;2;22;0
WireConnection;0;9;26;0
ASEEND*/
//CHKSM=4E36963F12B49371D5827E667809327EBF5E5BAB