// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplifyshader/15Week/FXThunder"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_MainPower("MainPower", Float) = 1
		_Noise_U("Noise_U", Float) = 1
		_MainIns("MainIns", Float) = 1
		_Noise_V("Noise_V", Float) = 1
		[HDR]_MainColor("MainColor", Color) = (1,1,1,0)
		_Dissolve("Dissolve", Range( -1 , 1)) = 0.2747886
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _NoiseTex;
		uniform float _Noise_U;
		uniform float _Noise_V;
		uniform float _Dissolve;
		uniform float _MainPower;
		uniform float _MainIns;
		uniform float4 _MainColor;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 appendResult39 = (float2(_Noise_U , _Noise_V));
			float2 panner41 = ( 1.0 * _Time.y * appendResult39 + i.uv_texcoord);
			o.Emission = ( ( pow( ( tex2D( _MainTex, uv_MainTex ).r * saturate( ( tex2D( _NoiseTex, panner41 ).r + _Dissolve ) ) ) , _MainPower ) * _MainIns * _MainColor ) * i.vertexColor ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
403;325;1557;1122;1215.785;614.7086;1.362969;True;False
Node;AmplifyShaderEditor.RangedFloatNode;38;-1589.834,305.1527;Float;False;Property;_Noise_U;Noise_U;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1586.165,450.0968;Float;False;Property;_Noise_V;Noise_V;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-1200.87,367.5337;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;40;-1351.318,173.0518;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;41;-1092.62,167.5476;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-742.7977,186.2764;Float;True;Property;_NoiseTex;NoiseTex;2;0;Create;True;0;0;False;0;3c1b02a85ac349f4f9375a88a9fa62e6;3c1b02a85ac349f4f9375a88a9fa62e6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-729.5204,427.9399;Float;False;Property;_Dissolve;Dissolve;8;0;Create;True;0;0;False;0;0.2747886;0.284;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-428.6073,200.6737;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-746.6976,-229.7235;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;b2d187ea358a03045a7e2c2b5363b47c;b2d187ea358a03045a7e2c2b5363b47c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;3;-285.1982,216.1766;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-274.7978,-197.2237;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-191.81,-13.98089;Float;False;Property;_MainPower;MainPower;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;23;-256.8098,-454.6808;Float;False;Property;_MainColor;MainColor;7;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;5;-21.51072,-197.281;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;127.9904,-13.98077;Float;False;Property;_MainIns;MainIns;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;225.4904,-198.5803;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;27;268.3904,135.5191;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;421.7904,-197.2809;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;706.1998,38.20001;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplifyshader/15Week/FXThunder;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;0;38;0
WireConnection;39;1;37;0
WireConnection;41;0;40;0
WireConnection;41;2;39;0
WireConnection;2;1;41;0
WireConnection;35;0;2;1
WireConnection;35;1;36;0
WireConnection;3;0;35;0
WireConnection;4;0;1;1
WireConnection;4;1;3;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;24;0;5;0
WireConnection;24;1;25;0
WireConnection;24;2;23;0
WireConnection;26;0;24;0
WireConnection;26;1;27;0
WireConnection;0;2;26;0
WireConnection;0;9;27;4
ASEEND*/
//CHKSM=DD611ADAACD22238524784D33D703F988D4B2FEF