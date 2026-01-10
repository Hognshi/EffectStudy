// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/24Week/Water"
{
	Properties
	{
		_MaskTex("MaskTex", 2D) = "white" {}
		[Normal]_NormalTex("NormalTex", 2D) = "bump" {}
		_NormalU("NormalU", Float) = 0
		_NormalV("NormalV", Float) = 0
		_Distortion("Distortion", Float) = 0
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_Opacity("Opacity", Float) = 1
		_baseTex("baseTex", 2D) = "white" {}
		_BasePower("BasePower", Float) = 1
		_BaseIns("BaseIns", Float) = 1
		[HDR]_BaseColor("BaseColor", Color) = (1,1,1,0)
		_BaseU("BaseU", Float) = 0
		_BaseV("BaseV", Float) = 0
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
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
		};

		uniform sampler2D _baseTex;
		uniform float _BaseU;
		uniform float _BaseV;
		uniform float4 _baseTex_ST;
		uniform float _BasePower;
		uniform float _BaseIns;
		uniform float4 _BaseColor;
		uniform sampler2D _MaskTex;
		uniform sampler2D _NormalTex;
		uniform float _NormalU;
		uniform float _NormalV;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float4 _MaskTex_ST;
		uniform sampler2D _NoiseTex;
		uniform float4 _NoiseTex_ST;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult33 = (float2(_BaseU , _BaseV));
			float2 uv0_baseTex = i.uv_texcoord * _baseTex_ST.xy + _baseTex_ST.zw;
			float2 panner30 = ( 1.0 * _Time.y * appendResult33 + uv0_baseTex);
			o.Emission = ( ( pow( tex2D( _baseTex, panner30 ).r , _BasePower ) * _BaseIns * _BaseColor ) + i.vertexColor ).rgb;
			float2 appendResult10 = (float2(_NormalU , _NormalV));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner8 = ( 1.0 * _Time.y * appendResult10 + uv0_NormalTex);
			float2 temp_output_6_0 = ( (UnpackNormal( tex2D( _NormalTex, panner8 ) )).xy * _Distortion );
			float2 uv0_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			float2 uv0_NoiseTex = i.uv_texcoord * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * saturate( ( tex2D( _MaskTex, ( temp_output_6_0 + uv0_MaskTex ) ).r * ( tex2D( _NoiseTex, ( temp_output_6_0 + uv0_NoiseTex ) ).r + i.uv_tex4coord.z ) * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1132;295;1498;1095;1510.776;771.0038;1.746975;True;False
Node;AmplifyShaderEditor.RangedFloatNode;11;-2110.997,-170.336;Float;False;Property;_NormalU;NormalU;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-2110.995,-94.71211;Float;False;Property;_NormalV;NormalV;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1940.845,-376.9516;Float;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;10;-1907.083,-179.7893;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;8;-1681.564,-298.6273;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;4;-1420.932,-325.6357;Float;True;Property;_NormalTex;NormalTex;2;1;[Normal];Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-1036.061,-131.1747;Float;False;Property;_Distortion;Distortion;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;5;-1110.334,-321.5838;Float;False;True;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-855.103,-266.2167;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1339.555,-636.7123;Float;False;Property;_BaseU;BaseU;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1336.555,-539.7123;Float;False;Property;_BaseV;BaseV;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1017.435,469.3857;Float;False;0;16;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;31;-1240.555,-864.7123;Float;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1011.374,-12.81554;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;33;-1180.555,-603.7123;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-755.3124,416.0128;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;30;-936.5552,-736.7123;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-714.6585,-144.6794;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;16;-536.8328,402.5198;Float;True;Property;_NoiseTex;NoiseTex;6;0;Create;True;0;0;False;0;3c1b02a85ac349f4f9375a88a9fa62e6;3c1b02a85ac349f4f9375a88a9fa62e6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;22;-478.9602,634.2498;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-548.833,-40.43561;Float;True;Property;_MaskTex;MaskTex;1;0;Create;True;0;0;False;0;e0459bb22bc46494bbb4f965610f10a8;f810e6bd32fcd5e459a0ceb8ccff4e2f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-239.4475,160.1658;Float;False;Property;_Opacity;Opacity;7;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-326.875,-635.7145;Float;False;Property;_BasePower;BasePower;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-641.2007,-779.9504;Float;True;Property;_baseTex;baseTex;8;0;Create;True;0;0;False;0;a97293cb088254b488e60fdc79fea33d;a97293cb088254b488e60fdc79fea33d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-175.5895,433.6407;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;24;-215.2963,-752.736;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;-280.6106,-1016.715;Float;False;Property;_BaseColor;BaseColor;11;1;[HDR];Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-69.63496,-9.691645;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-95.55318,-635.7145;Float;False;Property;_BaseIns;BaseIns;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;40.51853,-752.7361;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;13;-447.4164,-318.9249;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;37;81.55249,-9.834167;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;241.9045,-344.5209;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;251.549,-222.0206;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;472.2839,-200.0081;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/24Week/Water;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;11;0
WireConnection;10;1;12;0
WireConnection;8;0;9;0
WireConnection;8;2;10;0
WireConnection;4;1;8;0
WireConnection;5;0;4;0
WireConnection;6;0;5;0
WireConnection;6;1;7;0
WireConnection;33;0;34;0
WireConnection;33;1;35;0
WireConnection;17;0;6;0
WireConnection;17;1;18;0
WireConnection;30;0;31;0
WireConnection;30;2;33;0
WireConnection;3;0;6;0
WireConnection;3;1;2;0
WireConnection;16;1;17;0
WireConnection;1;1;3;0
WireConnection;23;1;30;0
WireConnection;19;0;16;1
WireConnection;19;1;22;3
WireConnection;24;0;23;1
WireConnection;24;1;25;0
WireConnection;20;0;1;1
WireConnection;20;1;19;0
WireConnection;20;2;36;0
WireConnection;26;0;24;0
WireConnection;26;1;27;0
WireConnection;26;2;28;0
WireConnection;37;0;20;0
WireConnection;29;0;26;0
WireConnection;29;1;13;0
WireConnection;14;0;13;4
WireConnection;14;1;37;0
WireConnection;0;2;29;0
WireConnection;0;9;14;0
ASEEND*/
//CHKSM=C6A8868DBB5BE196E18E0C89C09C4614B76E365C