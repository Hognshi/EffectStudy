// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Particle"
{
	Properties
	{
		_FXT_ColorGradient("FXT_ColorGradient", 2D) = "white" {}
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_U("U", Float) = 1
		_V("V", Float) = 1
		_Ins("Ins", Float) = 1
		_Pow("Pow", Float) = 1
		_FXT_Particle("FXT_Particle", 2D) = "white" {}
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

		uniform sampler2D _FXT_ColorGradient;
		uniform sampler2D _NoiseTex;
		uniform float _U;
		uniform float _V;
		uniform float _Pow;
		uniform float _Ins;
		uniform sampler2D _FXT_Particle;
		uniform float4 _FXT_Particle_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (0.5).xx;
			float2 appendResult76 = (float2(_U , _V));
			float2 panner77 = ( 1.0 * _Time.y * appendResult76 + i.uv_texcoord);
			float2 temp_cast_1 = (( ( length( ( i.uv_texcoord - temp_cast_0 ) ) + ( tex2D( _NoiseTex, panner77 ).r * 0.1 ) ) + 0.0 )).xx;
			float4 temp_cast_2 = (_Pow).xxxx;
			float2 uv_FXT_Particle = i.uv_texcoord * _FXT_Particle_ST.xy + _FXT_Particle_ST.zw;
			float4 tex2DNode119 = tex2D( _FXT_Particle, uv_FXT_Particle );
			float temp_output_120_0 = ( tex2DNode119.r * i.vertexColor.a );
			o.Emission = ( ( ( pow( tex2D( _FXT_ColorGradient, temp_cast_1 ) , temp_cast_2 ) * _Ins ) * i.vertexColor * tex2DNode119 * temp_output_120_0 ) + float4( 0,0,0,0 ) ).rgb;
			o.Alpha = temp_output_120_0;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
442;504;1498;1083;-692.2453;170.2404;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;74;-964.8809,-270.7989;Float;False;Property;_U;U;3;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-963.5023,-195.175;Float;False;Property;_V;V;4;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-846.8672,-558.3879;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;76;-813.675,-264.9973;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;77;-672.1331,-286.0915;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-496.032,-401.4502;Float;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;63;-299.8549,-488.9575;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;66;-485.2405,-301.6165;Float;True;Property;_NoiseTex;NoiseTex;2;0;Create;True;0;0;False;0;b408675f3e50e3f4296a83bd62c5cc23;1ab104269e61d6c40969a74d1efcc866;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;68;-342.7297,-92.46809;Float;False;Constant;_Float4;Float 4;6;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;64;-107.032,-488.4504;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-128.7298,-195.468;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;70.27023,-156.468;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;90;277.9055,-165.9154;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;456.4099,-144.3243;Float;True;Property;_FXT_ColorGradient;FXT_ColorGradient;1;0;Create;True;0;0;False;0;9c06787883add984bb790cd9d873211e;9c06787883add984bb790cd9d873211e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;118;619.0044,-261.244;Float;False;Property;_Pow;Pow;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;115;810.0044,-139.244;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;117;924.0044,-250.244;Float;False;Property;_Ins;Ins;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;32;1131.997,58.92679;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;119;983.9874,278.1629;Float;True;Property;_FXT_Particle;FXT_Particle;7;0;Create;True;0;0;False;0;0f7861572aee0b14f849c8fa5849004b;0f7861572aee0b14f849c8fa5849004b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;1191.119,-136.3198;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;120;1354.062,142.313;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;1393.94,-12.91219;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;104;1596.655,-11.51747;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1912.764,-322.9953;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Particle;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;76;0;74;0
WireConnection;76;1;75;0
WireConnection;77;0;62;0
WireConnection;77;2;76;0
WireConnection;63;0;62;0
WireConnection;63;1;65;0
WireConnection;66;1;77;0
WireConnection;64;0;63;0
WireConnection;67;0;66;1
WireConnection;67;1;68;0
WireConnection;69;0;64;0
WireConnection;69;1;67;0
WireConnection;90;0;69;0
WireConnection;9;1;90;0
WireConnection;115;0;9;0
WireConnection;115;1;118;0
WireConnection;116;0;115;0
WireConnection;116;1;117;0
WireConnection;120;0;119;1
WireConnection;120;1;32;4
WireConnection;31;0;116;0
WireConnection;31;1;32;0
WireConnection;31;2;119;0
WireConnection;31;3;120;0
WireConnection;104;0;31;0
WireConnection;0;2;104;0
WireConnection;0;9;120;0
ASEEND*/
//CHKSM=70B5EB99F451F292F8565226B307B557513C6BED