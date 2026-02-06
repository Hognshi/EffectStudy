// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/26week/FX_Magic_Circle"
{
	Properties
	{
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_Noise_Tex("Noise_Tex", 2D) = "white" {}
		_Noise_Tile("Noise_Tile", Vector) = (1,1,0,0)
		_Noise_Panner("Noise_Panner", Vector) = (0,-1,0,0)
		_Main_Y_Offset("Main_Y_Offset", Float) = 0.24
		_Main_Power("Main_Power", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
		_Opacity("Opacity", Float) = 1
		[Toggle(_USE_CUSTOM_ON)] _USE_Custom("USE_Custom", Float) = 0
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
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Noise_Tex;
		uniform sampler2D _Sampler6020;
		uniform float2 _Noise_Tile;
		uniform float2 _Noise_Panner;
		uniform sampler2D _Main_Tex;
		uniform sampler2D _Sampler602;
		uniform float _Main_Y_Offset;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform sampler2D _Mask_Tex;
		uniform float4 _Mask_Tex_ST;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_output_1_0_g2 = float2( 1,1 );
			float2 appendResult10_g2 = (float2(( (temp_output_1_0_g2).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g2).y )));
			float2 temp_output_11_0_g2 = float2( 0,0 );
			float2 panner18_g2 = ( ( (temp_output_11_0_g2).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g2 = ( ( _Time.y * (temp_output_11_0_g2).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g2 = (float2((panner18_g2).x , (panner19_g2).y));
			float2 temp_output_47_0_g2 = _Noise_Panner;
			float2 uv_TexCoord78_g2 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g2 = ( uv_TexCoord78_g2 - float2( 1,1 ) );
			float2 appendResult39_g2 = (float2(frac( ( atan2( (temp_output_31_0_g2).x , (temp_output_31_0_g2).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g2 )));
			float2 panner54_g2 = ( ( (temp_output_47_0_g2).x * _Time.y ) * float2( 1,0 ) + appendResult39_g2);
			float2 panner55_g2 = ( ( _Time.y * (temp_output_47_0_g2).y ) * float2( 0,1 ) + appendResult39_g2);
			float2 appendResult58_g2 = (float2((panner54_g2).x , (panner55_g2).y));
			float2 temp_output_1_0_g1 = float2( 1,1 );
			float2 appendResult10_g1 = (float2(( (temp_output_1_0_g1).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g1).y )));
			float2 temp_output_11_0_g1 = float2( 0,0 );
			float2 panner18_g1 = ( ( (temp_output_11_0_g1).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g1 = ( ( _Time.y * (temp_output_11_0_g1).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g1 = (float2((panner18_g1).x , (panner19_g1).y));
			float2 temp_output_47_0_g1 = float2( 0,0 );
			float2 uv_TexCoord78_g1 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g1 = ( uv_TexCoord78_g1 - float2( 1,1 ) );
			float2 appendResult39_g1 = (float2(frac( ( atan2( (temp_output_31_0_g1).x , (temp_output_31_0_g1).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g1 )));
			float2 panner54_g1 = ( ( (temp_output_47_0_g1).x * _Time.y ) * float2( 1,0 ) + appendResult39_g1);
			float2 panner55_g1 = ( ( _Time.y * (temp_output_47_0_g1).y ) * float2( 0,1 ) + appendResult39_g1);
			float2 appendResult58_g1 = (float2((panner54_g1).x , (panner55_g1).y));
			float2 temp_output_2_0 = ( ( (tex2D( _Sampler602, ( appendResult10_g1 + appendResult24_g1 ) )).rg * 1.0 ) + ( float2( 1,1 ) * appendResult58_g1 ) );
			#ifdef _USE_CUSTOM_ON
				float staticSwitch33 = i.uv_tex4coord.z;
			#else
				float staticSwitch33 = _Main_Y_Offset;
			#endif
			float2 appendResult12 = (float2((temp_output_2_0).x , ( (temp_output_2_0).y + staticSwitch33 )));
			float temp_output_26_0 = ( pow( ( tex2D( _Noise_Tex, ( ( (tex2D( _Sampler6020, ( appendResult10_g2 + appendResult24_g2 ) )).rg * 1.0 ) + ( _Noise_Tile * appendResult58_g2 ) ) ).r * tex2D( _Main_Tex, appendResult12 ).r ) , _Main_Power ) * _Main_Ins );
			o.Emission = ( temp_output_26_0 * i.vertexColor ).rgb;
			float2 uv_Mask_Tex = i.uv_texcoord * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			o.Alpha = ( i.vertexColor.a * saturate( ( saturate( temp_output_26_0 ) * tex2D( _Mask_Tex, uv_Mask_Tex ).r * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;1705.475;1017.795;1.710726;False;False
Node;AmplifyShaderEditor.Vector2Node;8;-1649.43,-243.0496;Float;False;Constant;_Vector2;Vector 2;3;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;6;-1657.414,-108.1839;Float;False;Constant;_Vector3;Vector 3;3;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;2;-1430.414,-293.984;Float;False;RadialUVDistortion;-1;;1;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler602;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;32;-1146.312,184.5208;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1136.16,82.40521;Float;False;Property;_Main_Y_Offset;Main_Y_Offset;6;0;Create;True;0;0;False;0;0.24;0.24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;33;-901.312,103.5208;Float;False;Property;_USE_Custom;USE_Custom;10;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;11;-962.1741,-172.0656;Float;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;10;-957.3182,-462.0656;Float;True;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-686.8167,-127.8075;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;18;-1151.99,-613.9872;Float;False;Property;_Noise_Panner;Noise_Panner;5;0;Create;True;0;0;False;0;0,-1;0,-1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;19;-1150.006,-748.853;Float;False;Property;_Noise_Tile;Noise_Tile;4;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;12;-566.6679,-364.0199;Float;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;20;-924.9902,-799.7874;Float;False;RadialUVDistortion;-1;;2;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler6020;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;16;-318.1656,-571.6111;Float;True;Property;_Noise_Tex;Noise_Tex;3;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-285.1229,-307.5586;Float;True;Property;_Main_Tex;Main_Tex;2;0;Create;True;0;0;False;0;1401ed5ec8ef9cd45b1d405ec35f1ff7;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;55.28381,-461.0849;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;171.1674,-580.2859;Float;False;Property;_Main_Power;Main_Power;7;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;25;329.8885,-465.3069;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;418.6223,-579.0361;Float;False;Property;_Main_Ins;Main_Ins;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;559.8469,-469.0565;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;294.8963,-28.49409;Float;True;Property;_Mask_Tex;Mask_Tex;1;0;Create;True;0;0;False;0;607e11fd9de6afd4a9e3783fdaa9e0b7;607e11fd9de6afd4a9e3783fdaa9e0b7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;728.5661,108.3388;Float;False;Property;_Opacity;Opacity;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;27;702.3208,-232.8491;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;882.5104,-29.27485;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;31;1033.511,-40.38416;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;21;1001.641,-289.3439;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;1183.027,-450.2687;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1209.115,-106.7081;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1368.48,-437.9836;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/26week/FX_Magic_Circle;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;68;8;0
WireConnection;2;47;6;0
WireConnection;33;1;14;0
WireConnection;33;0;32;3
WireConnection;11;0;2;0
WireConnection;10;0;2;0
WireConnection;13;0;11;0
WireConnection;13;1;33;0
WireConnection;12;0;10;0
WireConnection;12;1;13;0
WireConnection;20;68;19;0
WireConnection;20;47;18;0
WireConnection;16;1;20;0
WireConnection;7;1;12;0
WireConnection;15;0;16;1
WireConnection;15;1;7;1
WireConnection;25;0;15;0
WireConnection;25;1;28;0
WireConnection;26;0;25;0
WireConnection;26;1;29;0
WireConnection;27;0;26;0
WireConnection;17;0;27;0
WireConnection;17;1;1;1
WireConnection;17;2;30;0
WireConnection;31;0;17;0
WireConnection;22;0;26;0
WireConnection;22;1;21;0
WireConnection;23;0;21;4
WireConnection;23;1;31;0
WireConnection;0;2;22;0
WireConnection;0;9;23;0
ASEEND*/
//CHKSM=516C0A3F8F5526340F3BACD7A425CCAD17CAFA2E