// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/28Week/FX_Slash_Projectile_Aura"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_Noise_U("Noise_U", Float) = 0
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
		_Nosie_V("Nosie_V", Float) = 0
		_Dissolve("Dissolve", Range( -1 , 1)) = 0
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
		uniform float _Nosie_V;
		uniform float4 _NoiseTex_ST;
		uniform float _Dissolve;
		uniform float _Main_Pow;
		uniform float _Main_Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 appendResult9 = (float2(_Noise_U , _Nosie_V));
			float2 uv0_NoiseTex = i.uv_texcoord * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			float2 panner8 = ( 1.0 * _Time.y * appendResult9 + uv0_NoiseTex);
			o.Emission = ( ( pow( ( tex2D( _MainTex, uv0_MainTex ).r * saturate( ( tex2D( _NoiseTex, panner8 ).r + _Dissolve ) ) ) , _Main_Pow ) * _Main_Ins ) * i.vertexColor ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
526;306;1498;1035;1692.861;463.5422;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;10;-1264.124,296.364;Float;False;Property;_Noise_U;Noise_U;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1262.124,390.364;Float;False;Property;_Nosie_V;Nosie_V;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;9;-1078.124,326.364;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1170.487,142.6435;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;8;-932.5859,142.6434;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-409.1974,263.4734;Float;False;Property;_Dissolve;Dissolve;7;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-691.4441,53.21545;Float;True;Property;_NoiseTex;NoiseTex;2;0;Create;True;0;0;False;0;3c1b02a85ac349f4f9375a88a9fa62e6;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-687.6421,-167.6721;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-232.4471,95.76677;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-361,-182.5;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;c0ae82b7a04150d46a29d6f7a50e97f7;c0ae82b7a04150d46a29d6f7a50e97f7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;19;-130.5194,11.11787;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;93.32031,-186.3515;Float;False;Property;_Main_Pow;Main_Pow;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;23,-98.5;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;307.3203,-186.3515;Float;False;Property;_Main_Ins;Main_Ins;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;12;234.3203,-97.3515;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;428.3203,-95.3515;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;16;391.1793,66.12335;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;582.1793,-39.87665;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;852.8999,-85.2;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/28Week/FX_Slash_Projectile_Aura;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;8;0;7;0
WireConnection;8;2;9;0
WireConnection;2;1;8;0
WireConnection;18;0;2;1
WireConnection;18;1;20;0
WireConnection;1;1;6;0
WireConnection;19;0;18;0
WireConnection;3;0;1;1
WireConnection;3;1;19;0
WireConnection;12;0;3;0
WireConnection;12;1;14;0
WireConnection;13;0;12;0
WireConnection;13;1;15;0
WireConnection;17;0;13;0
WireConnection;17;1;16;0
WireConnection;0;2;17;0
ASEEND*/
//CHKSM=BB10B1A9686BC55E68802FF059C73EEA8525DB69