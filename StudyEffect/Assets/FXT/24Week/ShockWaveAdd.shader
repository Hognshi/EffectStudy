// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/24Week/WaterShockWaveAdd"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_Distortion("Distortion", Float) = 0
		_MainIns("MainIns", Float) = 1
		_MaseTex("MaseTex", 2D) = "white" {}
		_MainPow("MainPow", Float) = 1
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
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
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Distortion;
		uniform float _MainIns;
		uniform float _MainPow;
		uniform sampler2D _MaseTex;
		uniform float4 _MaseTex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float2 appendResult5 = (float2(i.uv_texcoord.x , ( i.uv_texcoord.y + i.uv_tex4coord.z )));
			float4 tex2DNode1 = tex2D( _MainTex, ( ( (UnpackNormal( tex2D( _TextureSample0, uv_TextureSample0 ) )).xyz * _Distortion ) + float3( appendResult5 ,  0.0 ) ).xy );
			o.Emission = ( tex2DNode1.r * i.vertexColor * _MainIns * pow( tex2DNode1.r , _MainPow ) ).rgb;
			float2 uv_MaseTex = i.uv_texcoord * _MaseTex_ST.xy + _MaseTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * tex2D( _MaseTex, uv_MaseTex ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
572;477;1498;1103;966.3079;451.6081;1.113345;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-982,29;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;3;-975,298;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1302.432,-253.5237;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;b3d940e75e1f5d24684cd93a2758e1bf;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-726,218;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;8;-935.597,-234.1093;Float;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-920.2692,-91.05385;Float;False;Property;_Distortion;Distortion;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;5;-651.9565,58.02181;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-735.3185,-208.5637;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-507.3242,-53.99817;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-339.3117,-14.28372;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;63d11c832ea01734f98eb53b7ebe4089;63d11c832ea01734f98eb53b7ebe4089;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-227.0471,-125.3981;Float;False;Property;_MainPow;MainPow;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;11;-24.3125,98.96796;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-401.277,370.3867;Float;True;Property;_MaseTex;MaseTex;5;0;Create;True;0;0;False;0;f0999184e941eee47b8847f759ee7c0e;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;16;-78.97253,-110.9249;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;82.18176,-113.7028;Float;False;Property;_MainIns;MainIns;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;160.6875,53.96796;Float;False;4;4;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;279.5243,268.7256;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;494.0012,2.093221;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/24Week/WaterShockWaveAdd;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;2;2
WireConnection;4;1;3;3
WireConnection;8;0;7;0
WireConnection;5;0;2;1
WireConnection;5;1;4;0
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;6;0;9;0
WireConnection;6;1;5;0
WireConnection;1;1;6;0
WireConnection;16;0;1;1
WireConnection;16;1;17;0
WireConnection;12;0;1;1
WireConnection;12;1;11;0
WireConnection;12;2;13;0
WireConnection;12;3;16;0
WireConnection;15;0;11;4
WireConnection;15;1;14;1
WireConnection;0;2;12;0
WireConnection;0;9;15;0
ASEEND*/
//CHKSM=D9F7E806619F15EC725E93708EF109E499C97D01