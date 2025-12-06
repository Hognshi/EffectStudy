// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/20Week/FXT_CrackToon"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,1,1,0)
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_ParallaxOffset("ParallaxOffset", Range( -0.1 , 0.1)) = 0
		_Dissolve("Dissolve", Range( -1 , 1)) = 0.1490765
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform float4 _Color0;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _ParallaxOffset;
		uniform sampler2D _NoiseTex;
		uniform float4 _NoiseTex_ST;
		uniform float _Dissolve;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			o.Emission = ( _Color0 * tex2D( _MainTex, uv_MainTex ) ).rgb;
			float2 paralaxOffset21 = ParallaxOffset( 0 , _ParallaxOffset , i.viewDir );
			float2 uv_NoiseTex = i.uv_texcoord * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			o.Alpha = saturate( ( tex2D( _MainTex, ( i.uv_texcoord + paralaxOffset21 ) ).r * step( 0.1 , ( tex2D( _NoiseTex, uv_NoiseTex ).r + _Dissolve ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
739;158;1498;1120;2147.644;212.0495;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;22;-1881.144,596.5504;Float;False;Property;_ParallaxOffset;ParallaxOffset;3;0;Create;True;0;0;False;0;0;0;-0.1;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;25;-1842.145,734.351;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;7;-984.8269,803.761;Float;True;Property;_NoiseTex;NoiseTex;2;0;Create;True;0;0;False;0;2501e4ecfb5b5c749ad526597f3b4c2b;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;21;-1533.309,578.0962;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-1567.844,345.6504;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-954.9267,723.1606;Float;False;Property;_Dissolve;Dissolve;4;0;Create;True;0;0;False;0;0.1490765;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-531.1262,558.0607;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-1245.443,493.8505;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;4;-1171.787,194.3545;Float;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;False;0;a8159fb276863694089955268b9671b2;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-592.2266,706.2616;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;19;-403.7262,668.561;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-927.5238,415.9654;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;a8159fb276863694089955268b9671b2;a8159fb276863694089955268b9671b2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-347.8275,446.2614;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-931.787,194.3545;Float;True;Property;_MainnTEX;MainnTEX;1;0;Create;True;0;0;False;0;a8159fb276863694089955268b9671b2;a8159fb276863694089955268b9671b2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-984.787,-147.6455;Float;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;18;-163.2264,461.8609;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-570.787,45.35446;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/20Week/FXT_CrackToon;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;1;22;0
WireConnection;21;2;25;0
WireConnection;24;0;23;0
WireConnection;24;1;21;0
WireConnection;16;0;7;1
WireConnection;16;1;17;0
WireConnection;19;0;20;0
WireConnection;19;1;16;0
WireConnection;6;0;4;0
WireConnection;6;1;24;0
WireConnection;15;0;6;1
WireConnection;15;1;19;0
WireConnection;5;0;4;0
WireConnection;18;0;15;0
WireConnection;2;0;3;0
WireConnection;2;1;5;0
WireConnection;0;2;2;0
WireConnection;0;9;18;0
ASEEND*/
//CHKSM=3FCDE398D30AE832D90826CF719E71B01EC3AE83