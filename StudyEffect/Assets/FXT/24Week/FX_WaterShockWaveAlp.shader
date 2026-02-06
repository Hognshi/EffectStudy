// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/24Week/WaterShockWave_Alp"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_MainU("MainU", Float) = 0
		_MainV("MainV", Float) = 0
		_FX_Mask("FX_Mask", 2D) = "white" {}
		[HDR]_AddColor("AddColor", Color) = (1,1,1,0)
		_MainPower("MainPower", Float) = 1
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

		uniform sampler2D _MainTex;
		uniform float _MainU;
		uniform float _MainV;
		uniform float4 _MainTex_ST;
		uniform float _MainPower;
		uniform float4 _AddColor;
		uniform sampler2D _FX_Mask;
		uniform float4 _FX_Mask_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult4 = (float2(_MainU , _MainV));
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 panner3 = ( 1.0 * _Time.y * appendResult4 + uv0_MainTex);
			o.Emission = ( ( pow( tex2D( _MainTex, panner3 ).r , _MainPower ) * _AddColor ) + i.vertexColor ).rgb;
			float2 uv_FX_Mask = i.uv_texcoord * _FX_Mask_ST.xy + _FX_Mask_ST.zw;
			o.Alpha = ( i.vertexColor.a * tex2D( _FX_Mask, uv_FX_Mask ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
653;418;1498;1096;855.8999;543.1328;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;5;-1145.423,186.7629;Float;False;Property;_MainU;MainU;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1142.423,265.7629;Float;False;Property;_MainV;MainV;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-929.4233,172.7629;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1060.423,-7.237101;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;3;-777.4233,-1.2371;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-537.7233,-29.93709;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;3c1b02a85ac349f4f9375a88a9fa62e6;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-322.8999,165.8672;Float;False;Property;_MainPower;MainPower;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-446.8999,-283.1328;Float;False;Property;_AddColor;AddColor;5;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;15;-171.8999,-8.132751;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;7;-34.00471,100.3281;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-332.8213,324.579;Float;True;Property;_FX_Mask;FX_Mask;4;0;Create;True;0;0;False;0;f0999184e941eee47b8847f759ee7c0e;f0999184e941eee47b8847f759ee7c0e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-43.82129,-154.421;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;147.9956,257.6281;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;180.1001,-0.1327515;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;421.1999,-48.09999;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/24Week/WaterShockWave_Alp;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;5;0
WireConnection;4;1;6;0
WireConnection;3;0;2;0
WireConnection;3;2;4;0
WireConnection;1;1;3;0
WireConnection;15;0;1;1
WireConnection;15;1;16;0
WireConnection;12;0;15;0
WireConnection;12;1;13;0
WireConnection;9;0;7;4
WireConnection;9;1;11;1
WireConnection;14;0;12;0
WireConnection;14;1;7;0
WireConnection;0;2;14;0
WireConnection;0;9;9;0
ASEEND*/
//CHKSM=AAF07C17A40BD3ECB10EAE10E6CF8843D0275B77