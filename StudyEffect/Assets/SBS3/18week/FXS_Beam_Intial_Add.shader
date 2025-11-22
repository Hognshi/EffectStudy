// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/18week/FX_Beam_Intial"
{
	Properties
	{
		_Emi_Ins("Emi_Ins", Float) = 1
		_MainTex("MainTex", 2D) = "white" {}
		_Main_Upanner("Main_Upanner", Float) = 0
		_Main_Vpanner("Main_Vpanner", Float) = 0
		_Rot("Rot", Float) = 2
		_MaskTex("MaskTex", 2D) = "white" {}
		_Range("Range", Float) = 0.1
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

		uniform float _Emi_Ins;
		uniform float _Range;
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
			o.Emission = ( _Emi_Ins * step( _Range , tex2D( _MainTex, panner8 ).r ) * i.vertexColor ).rgb;
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * tex2D( _MaskTex, uv_MaskTex ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;2442.853;678.8961;1.801382;True;False
Node;AmplifyShaderEditor.RangedFloatNode;6;-1870.785,349.3119;Float;False;Property;_Rot;Rot;5;0;Create;True;0;0;False;0;2;1.91;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1939.672,-71.33717;Float;True;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1622.785,276.3119;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-926.1693,82.43393;Float;False;Property;_Main_Upanner;Main_Upanner;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-926.1693,177.4339;Float;False;Property;_Main_Vpanner;Main_Vpanner;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-1385.785,172.3119;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;9;-702.263,86.73134;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-1163.785,-38.68808;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;8;-549.1716,-36.96826;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-265.5,-70.5;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;8d21b35fab1359d4aa689ddf302e1b01;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-62.92676,-292.8487;Float;False;Property;_Range;Range;7;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;13;140.0732,-65.84872;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;281.3892,-301.569;Float;False;Property;_Emi_Ins;Emi_Ins;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;17;294.3892,160.431;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;183.358,387.9073;Float;True;Property;_MaskTex;MaskTex;6;0;Create;True;0;0;False;0;7f78920f34007b34ca97216413e97960;7f78920f34007b34ca97216413e97960;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;479.3892,-86.56903;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;605.3892,231.431;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;760.67,-133.1948;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/18week/FX_Beam_Intial;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
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
WireConnection;13;0;14;0
WireConnection;13;1;1;1
WireConnection;15;0;16;0
WireConnection;15;1;13;0
WireConnection;15;2;17;0
WireConnection;18;0;17;4
WireConnection;18;1;12;1
WireConnection;0;2;15;0
WireConnection;0;9;18;0
ASEEND*/
//CHKSM=77D93C6FD2C1468FFDF9CDDE8B90FEC503481D46