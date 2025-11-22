// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/18week/FX_Beam_Intial_Alp"
{
	Properties
	{
		_Emi_Ins("Emi_Ins", Float) = 1
		_MainTex("MainTex", 2D) = "white" {}
		_Main_Upanner("Main_Upanner", Float) = 0
		_Main_Vpanner("Main_Vpanner", Float) = 0
		_Rot("Rot", Float) = 2
		_MaskTex("MaskTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _Emi_Ins;
		uniform sampler2D _MainTex;
		uniform float _Main_Upanner;
		uniform float _Main_Vpanner;
		uniform float4 _MainTex_ST;
		uniform float _Rot;
		uniform sampler2D _MaskTex;
		uniform float4 _MaskTex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult9 = (float2(_Main_Upanner , _Main_Vpanner));
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 appendResult4 = (float2(uv0_MainTex.x , ( uv0_MainTex.x + ( uv0_MainTex.y * _Rot ) )));
			float2 panner8 = ( 1.0 * _Time.y * appendResult9 + appendResult4);
			float4 tex2DNode1 = tex2D( _MainTex, panner8 );
			o.Emission = ( _Emi_Ins * tex2DNode1.r * i.vertexColor ).rgb;
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * tex2D( _MaskTex, uv_MaskTex ).r * tex2DNode1.r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;651.3315;311.5139;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;6;-1582.333,323.3513;Float;False;Property;_Rot;Rot;5;0;Create;True;0;0;False;0;2;1.91;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1651.22,-97.29778;Float;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1334.333,250.3512;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-637.7173,56.47333;Float;False;Property;_Main_Upanner;Main_Upanner;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-637.7173,151.4733;Float;False;Property;_Main_Vpanner;Main_Vpanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-1097.333,146.3513;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;9;-413.8113,60.77074;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-875.333,-64.64869;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;8;-260.7202,-62.92887;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;281.3892,-301.569;Float;False;Property;_Emi_Ins;Emi_Ins;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;17;294.3892,160.431;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;183.358,387.9073;Float;True;Property;_MaskTex;MaskTex;6;0;Create;True;0;0;False;0;7f78920f34007b34ca97216413e97960;7f78920f34007b34ca97216413e97960;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;22.95124,-96.46061;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;479.3892,-86.56903;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;588.3892,263.431;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;760.67,-133.1948;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/18week/FX_Beam_Intial_Alp;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;2;2
WireConnection;5;1;6;0
WireConnection;7;0;2;1
WireConnection;7;1;5;0
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;4;0;2;1
WireConnection;4;1;7;0
WireConnection;8;0;4;0
WireConnection;8;2;9;0
WireConnection;1;1;8;0
WireConnection;15;0;16;0
WireConnection;15;1;1;1
WireConnection;15;2;17;0
WireConnection;18;0;17;4
WireConnection;18;1;12;1
WireConnection;18;2;1;1
WireConnection;0;2;15;0
WireConnection;0;9;18;0
ASEEND*/
//CHKSM=7B1F848DAC20841B73ECBA1005B364642CD130E1