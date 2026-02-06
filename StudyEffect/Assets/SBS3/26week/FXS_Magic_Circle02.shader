// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/26week/FX_Magic_Circle02"
{
	Properties
	{
		_FXT_Ice_Magic("FXT_Ice_Magic", 2D) = "white" {}
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_Noise_Y_Offset("Noise_Y_Offset", Range( -1 , 1)) = 0.2588235
		_Normal_Tex("Normal_Tex", 2D) = "bump" {}
		_Distortion("Distortion", Range( 0 , 1)) = 0.3058824
		_Main_Power("Main_Power", Float) = 2.24
		_Main_Ins("Main_Ins", Float) = 1
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[Toggle]_USE_Custom("USE_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha One
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

		uniform sampler2D _TextureSample1;
		uniform sampler2D _Sampler6033;
		uniform sampler2D _Main_Tex;
		uniform sampler2D _Normal_Tex;
		uniform sampler2D _Sampler6015;
		uniform float _Distortion;
		uniform sampler2D _Sampler603;
		uniform float _Noise_Y_Offset;
		uniform float _USE_Custom;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform sampler2D _FXT_Ice_Magic;
		uniform float4 _FXT_Ice_Magic_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_output_1_0_g3 = float2( 1,1 );
			float2 appendResult10_g3 = (float2(( (temp_output_1_0_g3).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g3).y )));
			float2 temp_output_11_0_g3 = float2( 0,0 );
			float2 panner18_g3 = ( ( (temp_output_11_0_g3).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g3 = ( ( _Time.y * (temp_output_11_0_g3).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g3 = (float2((panner18_g3).x , (panner19_g3).y));
			float2 temp_output_47_0_g3 = float2( 0,-0.2 );
			float2 uv_TexCoord78_g3 = i.uv_texcoord * float2( 2,2 );
			float2 temp_output_31_0_g3 = ( uv_TexCoord78_g3 - float2( 1,1 ) );
			float2 appendResult39_g3 = (float2(frac( ( atan2( (temp_output_31_0_g3).x , (temp_output_31_0_g3).y ) / 6.28318548202515 ) ) , length( temp_output_31_0_g3 )));
			float2 panner54_g3 = ( ( (temp_output_47_0_g3).x * _Time.y ) * float2( 1,0 ) + appendResult39_g3);
			float2 panner55_g3 = ( ( _Time.y * (temp_output_47_0_g3).y ) * float2( 0,1 ) + appendResult39_g3);
			float2 appendResult58_g3 = (float2((panner54_g3).x , (panner55_g3).y));
			float2 temp_output_1_0_g2 = float2( 1,1 );
			float2 appendResult10_g2 = (float2(( (temp_output_1_0_g2).x * i.uv_texcoord.x ) , ( i.uv_texcoord.y * (temp_output_1_0_g2).y )));
			float2 temp_output_11_0_g2 = float2( 0,0 );
			float2 panner18_g2 = ( ( (temp_output_11_0_g2).x * _Time.y ) * float2( 1,0 ) + i.uv_texcoord);
			float2 panner19_g2 = ( ( _Time.y * (temp_output_11_0_g2).y ) * float2( 0,1 ) + i.uv_texcoord);
			float2 appendResult24_g2 = (float2((panner18_g2).x , (panner19_g2).y));
			float2 temp_output_47_0_g2 = float2( 0,-0.2 );
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
			float2 temp_output_3_0 = ( ( (tex2D( _Sampler603, ( appendResult10_g1 + appendResult24_g1 ) )).rg * 1.0 ) + ( float2( 2,1 ) * appendResult58_g1 ) );
			float lerpResult37 = lerp( _Noise_Y_Offset , i.uv_tex4coord.z , _USE_Custom);
			float2 appendResult9 = (float2((temp_output_3_0).x , ( (temp_output_3_0).y + lerpResult37 )));
			float temp_output_23_0 = ( pow( tex2D( _Main_Tex, ( ( (UnpackNormal( tex2D( _Normal_Tex, ( ( (tex2D( _Sampler6015, ( appendResult10_g2 + appendResult24_g2 ) )).rg * 1.0 ) + ( float2( 4,0.2 ) * appendResult58_g2 ) ) ) )).xy * _Distortion ) + appendResult9 ) ).r , _Main_Power ) * _Main_Ins );
			o.Emission = ( ( tex2D( _TextureSample1, ( ( (tex2D( _Sampler6033, ( appendResult10_g3 + appendResult24_g3 ) )).rg * 1.0 ) + ( float2( 2,0.5 ) * appendResult58_g3 ) ) ).r * temp_output_23_0 ) * i.vertexColor ).rgb;
			float2 uv_FXT_Ice_Magic = i.uv_texcoord * _FXT_Ice_Magic_ST.xy + _FXT_Ice_Magic_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( saturate( temp_output_23_0 ) * tex2D( _FXT_Ice_Magic, uv_FXT_Ice_Magic ).r ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
67;109;1920;934;1739.037;831.4984;1;True;False
Node;AmplifyShaderEditor.Vector2Node;4;-1068.499,-4.300004;Float;False;Constant;_Vector2;Vector 2;3;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;5;-1066.499,-137.3;Float;False;Constant;_Vector3;Vector 3;3;0;Create;True;0;0;False;0;2,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;17;-1176.865,-618.467;Float;False;Constant;_Vector5;Vector 5;3;0;Create;True;0;0;False;0;4,0.2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;16;-1188.465,-485.4666;Float;False;Constant;_Vector4;Vector 4;3;0;Create;True;0;0;False;0;0,-0.2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexCoordVertexDataNode;35;-748.3611,221.8959;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-817.5001,111.7;Float;False;Property;_Noise_Y_Offset;Noise_Y_Offset;3;0;Create;True;0;0;False;0;0.2588235;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-581.0105,384.7977;Float;False;Property;_USE_Custom;USE_Custom;9;1;[Toggle];Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;3;-870.4994,-163.3;Float;False;RadialUVDistortion;-1;;1;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler603;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;15;-980.865,-644.467;Float;False;RadialUVDistortion;-1;;2;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler6015;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;14;-561.8988,-666.7004;Float;True;Property;_Normal_Tex;Normal_Tex;4;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;37;-391.0105,116.7977;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;8;-404.5002,-94.29998;Float;False;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-344.9004,-440.6999;Float;False;Property;_Distortion;Distortion;5;0;Create;True;0;0;False;0;0.3058824;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;7;-402.5002,-287.3001;Float;False;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;18;-246.3004,-663.1004;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-193.5002,-1.300004;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-42.89998,-548.7004;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;9;-76.49998,-212.3;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;79.50002,-431.3001;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;223.4999,-230.3;Float;True;Property;_Main_Tex;Main_Tex;2;0;Create;True;0;0;False;0;1ccc6821486dd72419e0356efa28e869;1ccc6821486dd72419e0356efa28e869;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;373,-343;Float;False;Property;_Main_Power;Main_Power;6;0;Create;True;0;0;False;0;2.24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;34;84.19226,-652.4839;Float;False;Constant;_Vector7;Vector 7;3;0;Create;True;0;0;False;0;0,-0.2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;24;636.6996,-352.6;Float;False;Property;_Main_Ins;Main_Ins;7;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;32;95.79224,-785.4843;Float;False;Constant;_Vector6;Vector 6;3;0;Create;True;0;0;False;0;2,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PowerNode;21;543,-231;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;799.6996,-235.6;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;33;291.7922,-811.4843;Float;False;RadialUVDistortion;-1;;3;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler6033;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;25;1037.599,6;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;772.5994,216;Float;True;Property;_FXT_Ice_Magic;FXT_Ice_Magic;1;0;Create;True;0;0;False;0;607e11fd9de6afd4a9e3783fdaa9e0b7;607e11fd9de6afd4a9e3783fdaa9e0b7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;733.0153,-651.142;Float;True;Property;_TextureSample1;Texture Sample 1;8;0;Create;True;0;0;False;0;8d21b35fab1359d4aa689ddf302e1b01;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;1185.599,150;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;1104.476,-377.6595;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;27;1175.4,-154.0001;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1342.4,-241;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;1344.4,42.00001;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1506.4,-197;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/26week/FX_Magic_Circle02;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;8;5;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;68;5;0
WireConnection;3;47;4;0
WireConnection;15;68;17;0
WireConnection;15;47;16;0
WireConnection;14;1;15;0
WireConnection;37;0;12;0
WireConnection;37;1;35;3
WireConnection;37;2;38;0
WireConnection;8;0;3;0
WireConnection;7;0;3;0
WireConnection;18;0;14;0
WireConnection;11;0;8;0
WireConnection;11;1;37;0
WireConnection;19;0;18;0
WireConnection;19;1;20;0
WireConnection;9;0;7;0
WireConnection;9;1;11;0
WireConnection;13;0;19;0
WireConnection;13;1;9;0
WireConnection;2;1;13;0
WireConnection;21;0;2;1
WireConnection;21;1;22;0
WireConnection;23;0;21;0
WireConnection;23;1;24;0
WireConnection;33;68;32;0
WireConnection;33;47;34;0
WireConnection;25;0;23;0
WireConnection;31;1;33;0
WireConnection;26;0;25;0
WireConnection;26;1;1;1
WireConnection;30;0;31;1
WireConnection;30;1;23;0
WireConnection;28;0;30;0
WireConnection;28;1;27;0
WireConnection;29;0;27;4
WireConnection;29;1;26;0
WireConnection;0;2;28;0
WireConnection;0;9;29;0
ASEEND*/
//CHKSM=1643EB9A25DF8716E2FF01B6BF98FBE910F0B66C