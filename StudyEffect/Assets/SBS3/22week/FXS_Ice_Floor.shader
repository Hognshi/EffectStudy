// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/22week/FX_Ice_Floor"
{
	Properties
	{
		_Main_Tex("Main_Tex", 2D) = "white" {}
		_Mask_Tex("Mask_Tex", 2D) = "white" {}
		_Desaturate("Desaturate", Range( 0 , 1)) = 0
		_Main_Power("Main_Power", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
		[HDR]_Color0("Color 0", Color) = (1,1,1,0)
		_Parallax_Tex("Parallax_Tex", 2D) = "white" {}
		_Parallax_Offset("Parallax_Offset", Range( -0.5 , 0.5)) = 0
		_Parallax_Panner("Parallax_Panner", Vector) = (0,0,0,0)
		_Normal_Tex("Normal_Tex", 2D) = "bump" {}
		_Normal_Tile("Normal_Tile", Vector) = (0,0,0,0)
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
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float3 viewDir;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Main_Tex;
		uniform sampler2D _Normal_Tex;
		uniform sampler2D _Sampler6023;
		uniform float2 _Normal_Tile;
		uniform float4 _Main_Tex_ST;
		uniform sampler2D _Parallax_Tex;
		uniform float2 _Parallax_Panner;
		uniform float4 _Parallax_Tex_ST;
		uniform float _Parallax_Offset;
		uniform float _Desaturate;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform float4 _Color0;
		uniform sampler2D _Mask_Tex;
		uniform float4 _Mask_Tex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
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
			float2 temp_cast_0 = (0.5).xx;
			float2 temp_output_26_0 = ( (UnpackNormal( tex2D( _Normal_Tex, ( ( (tex2D( _Sampler6023, ( appendResult10_g1 + appendResult24_g1 ) )).rg * 1.0 ) + ( _Normal_Tile * appendResult58_g1 ) ) ) )).xy * saturate( ( pow( length( ( i.uv_texcoord - temp_cast_0 ) ) , 2.0 ) * 3.0 ) ) * i.uv_tex4coord.z );
			float2 uv0_Main_Tex = i.uv_texcoord * _Main_Tex_ST.xy + _Main_Tex_ST.zw;
			float2 uv0_Parallax_Tex = i.uv_texcoord * _Parallax_Tex_ST.xy + _Parallax_Tex_ST.zw;
			float2 panner21 = ( 1.0 * _Time.y * _Parallax_Panner + uv0_Parallax_Tex);
			float2 paralaxOffset16 = ParallaxOffset( tex2D( _Parallax_Tex, panner21 ).r , _Parallax_Offset , i.viewDir );
			float3 desaturateInitialColor3 = tex2D( _Main_Tex, ( temp_output_26_0 + uv0_Main_Tex + paralaxOffset16 ) ).rgb;
			float desaturateDot3 = dot( desaturateInitialColor3, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar3 = lerp( desaturateInitialColor3, desaturateDot3.xxx, _Desaturate );
			float3 temp_cast_2 = (_Main_Power).xxx;
			o.Emission = ( ( float4( pow( desaturateVar3 , temp_cast_2 ) , 0.0 ) * _Main_Ins * _Color0 ) * i.vertexColor ).rgb;
			float2 uv0_Mask_Tex = i.uv_texcoord * _Mask_Tex_ST.xy + _Mask_Tex_ST.zw;
			o.Alpha = ( i.vertexColor.a * tex2D( _Mask_Tex, ( temp_output_26_0 + uv0_Mask_Tex ) ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;2947.892;1595.728;2.267792;False;False
Node;AmplifyShaderEditor.RangedFloatNode;33;-2473.081,-424.105;Float;False;Constant;_Float0;Float 0;13;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;-2655.595,-584.2539;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;32;-2252.081,-587.105;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;34;-1969.081,-587.105;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;30;-2732.118,16.88433;Float;False;Property;_Normal_Tile;Normal_Tile;12;0;Create;True;0;0;False;0;0,0;3,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;38;-1841.081,-380.105;Float;False;Constant;_Float2;Float 2;13;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;22;-1890.869,-959.3399;Float;False;Property;_Parallax_Panner;Parallax_Panner;9;0;Create;True;0;0;False;0;0,0;0.002,0.002;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;36;-1596.081,-380.005;Float;False;Constant;_Float1;Float 1;13;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1939.421,-1198.268;Float;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;37;-1639.081,-583.105;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;23;-2563.682,-74.55725;Float;False;RadialUVDistortion;-1;;1;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;_Sampler6023;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;0,0;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;21;-1665.995,-1090.942;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1413.081,-585.105;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;-2034.302,-100.1221;Float;True;Property;_Normal_Tex;Normal_Tex;10;0;Create;True;0;0;False;0;None;ca13f4c0cd8f4eb4fb22f7b62e6e0d7e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;25;-1694.754,-99.43146;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;40;-1425.802,67.20661;Float;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;19;-1300.44,-791.6758;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;17;-1406.147,-1122.07;Float;True;Property;_Parallax_Tex;Parallax_Tex;7;0;Create;True;0;0;False;0;a3c943a6914a9f84a8f678a08b3f2e14;a3c943a6914a9f84a8f678a08b3f2e14;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-1386.44,-892.6755;Float;False;Property;_Parallax_Offset;Parallax_Offset;8;0;Create;True;0;0;False;0;0;-0.082;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;39;-1229.081,-302.105;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1130.185,-98.36609;Float;True;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;16;-1061.546,-910.1698;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1138.39,-482.3456;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-819.7875,-507.1617;Float;True;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-505.8242,-529.2649;Float;True;Property;_Main_Tex;Main_Tex;1;0;Create;True;0;0;False;0;5026617860db53446af7f1e89cb2f0a8;5026617860db53446af7f1e89cb2f0a8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-229,-420.5;Float;False;Property;_Desaturate;Desaturate;3;0;Create;True;0;0;False;0;0;0.276;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;126.9994,-394.5498;Float;False;Property;_Main_Power;Main_Power;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-898.7136,138.494;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;3;50,-519.5;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;6;302.9994,-520.5498;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;10;309.9994,-748.5498;Float;False;Property;_Color0;Color 0;6;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;345.9994,-398.5498;Float;False;Property;_Main_Ins;Main_Ins;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-652.5165,43.6546;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;11;495.9994,-305.5498;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;518.9994,-519.5498;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-497.8516,50.88805;Float;True;Property;_Mask_Tex;Mask_Tex;2;0;Create;True;0;0;False;0;1ae0fcdd40954f845975d91f63909b69;1ae0fcdd40954f845975d91f63909b69;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;719.9994,-433.5498;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;722.2645,54.89546;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1110.069,281.2294;Float;False;Property;_Distortion;Distortion;11;0;Create;True;0;0;False;0;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;961,-235;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/22week/FX_Ice_Floor;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;31;0
WireConnection;32;1;33;0
WireConnection;34;0;32;0
WireConnection;37;0;34;0
WireConnection;37;1;38;0
WireConnection;23;68;30;0
WireConnection;21;0;20;0
WireConnection;21;2;22;0
WireConnection;35;0;37;0
WireConnection;35;1;36;0
WireConnection;24;1;23;0
WireConnection;25;0;24;0
WireConnection;17;1;21;0
WireConnection;39;0;35;0
WireConnection;26;0;25;0
WireConnection;26;1;39;0
WireConnection;26;2;40;3
WireConnection;16;0;17;1
WireConnection;16;1;18;0
WireConnection;16;2;19;0
WireConnection;15;0;26;0
WireConnection;15;1;14;0
WireConnection;15;2;16;0
WireConnection;1;1;15;0
WireConnection;3;0;1;0
WireConnection;3;1;4;0
WireConnection;6;0;3;0
WireConnection;6;1;7;0
WireConnection;29;0;26;0
WireConnection;29;1;28;0
WireConnection;8;0;6;0
WireConnection;8;1;9;0
WireConnection;8;2;10;0
WireConnection;2;1;29;0
WireConnection;12;0;8;0
WireConnection;12;1;11;0
WireConnection;13;0;11;4
WireConnection;13;1;2;1
WireConnection;0;2;12;0
WireConnection;0;9;13;0
ASEEND*/
//CHKSM=C7161A36C01679483D8AFB8250339853B5EF4E56