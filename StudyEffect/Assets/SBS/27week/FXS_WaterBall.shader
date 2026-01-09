// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/27week/FX_WaterBall"
{
	Properties
	{
		_EmiTex("EmiTex", 2D) = "white" {}
		[HDR]_Emi_Color("Emi_Color", Color) = (1,1,1,0)
		_Desaturate("Desaturate", Range( 0 , 1)) = 0
		_Emi_Offset("Emi_Offset", Float) = 1
		_Emi_Range("Emi_Range", Float) = 1
		_Emi_Upanner("Emi_Upanner", Float) = 0
		_Emi_Vpanner("Emi_Vpanner", Float) = 0
		[HDR]_Fresnel_Color("Fresnel_Color", Color) = (1,1,1,0)
		_Fresnel_Power("Fresnel_Power", Float) = 4
		_Fresnel_Scale("Fresnel_Scale", Float) = 1
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_Dissolve("Dissolve", Range( 0 , 1)) = 0.4
		_Noise_Upanner("Noise_Upanner", Float) = 0
		_Noise_Vpanner("Noise_Vpanner", Float) = 0
		_Edge_Range("Edge_Range", Range( 0.1 , 0.8)) = 0.2451571
		[HDR]_Edge_Color("Edge_Color", Color) = (1,1,1,0)
		_NormalTex("NormalTex", 2D) = "bump" {}
		_Distortion("Distortion", Range( 0 , 1)) = 0
		_Normal_Upanner("Normal_Upanner", Float) = 0
		_Normal_Vpanner("Normal_Vpanner", Float) = 0
		_VertexTex("VertexTex", 2D) = "white" {}
		_Vertex_Normal_Str("Vertex_Normal_Str", Float) = 0
		_Vertex_Upanner("Vertex_Upanner", Float) = 0
		_Vertex_Vpanner("Vertex_Vpanner", Float) = 0
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
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform sampler2D _VertexTex;
		uniform float _Vertex_Upanner;
		uniform float _Vertex_Vpanner;
		uniform float4 _VertexTex_ST;
		uniform float _Vertex_Normal_Str;
		uniform sampler2D _EmiTex;
		uniform float _Emi_Upanner;
		uniform float _Emi_Vpanner;
		uniform float4 _EmiTex_ST;
		uniform sampler2D _NormalTex;
		uniform float _Normal_Upanner;
		uniform float _Normal_Vpanner;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float _Emi_Offset;
		uniform float _Emi_Range;
		uniform float _Desaturate;
		uniform float4 _Emi_Color;
		uniform float4 _Edge_Color;
		uniform sampler2D _NoiseTex;
		uniform float _Noise_Upanner;
		uniform float _Noise_Vpanner;
		uniform float4 _NoiseTex_ST;
		uniform float _Dissolve;
		uniform float _Edge_Range;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Power;
		uniform float4 _Fresnel_Color;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 appendResult65 = (float2(_Vertex_Upanner , _Vertex_Vpanner));
			float2 uv0_VertexTex = v.texcoord.xy * _VertexTex_ST.xy + _VertexTex_ST.zw;
			float2 panner64 = ( 1.0 * _Time.y * appendResult65 + uv0_VertexTex);
			v.vertex.xyz += ( ase_vertexNormal * ( tex2Dlod( _VertexTex, float4( panner64, 0, 0.0) ).r * _Vertex_Normal_Str ) );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult47 = (float2(_Emi_Upanner , _Emi_Vpanner));
			float2 uv0_EmiTex = i.uv_texcoord * _EmiTex_ST.xy + _EmiTex_ST.zw;
			float2 panner45 = ( 1.0 * _Time.y * appendResult47 + uv0_EmiTex);
			float2 appendResult42 = (float2(_Normal_Upanner , _Normal_Vpanner));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner41 = ( 1.0 * _Time.y * appendResult42 + uv0_NormalTex);
			float2 temp_output_38_0 = ( (UnpackNormal( tex2D( _NormalTex, panner41 ) )).xy * _Distortion );
			float4 temp_cast_0 = (_Emi_Offset).xxxx;
			float3 desaturateInitialColor33 = saturate( ( saturate( pow( tex2D( _EmiTex, ( panner45 + temp_output_38_0 ) ) , temp_cast_0 ) ) * _Emi_Range ) ).rgb;
			float desaturateDot33 = dot( desaturateInitialColor33, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar33 = lerp( desaturateInitialColor33, desaturateDot33.xxx, _Desaturate );
			float2 appendResult52 = (float2(_Noise_Upanner , _Noise_Vpanner));
			float2 uv0_NoiseTex = i.uv_texcoord * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			float2 panner50 = ( 1.0 * _Time.y * appendResult52 + uv0_NoiseTex);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch75 = i.uv_tex4coord.z;
			#else
				float staticSwitch75 = _Dissolve;
			#endif
			float temp_output_13_0 = (0.0 + (( tex2D( _NoiseTex, ( temp_output_38_0 + panner50 ) ).r + ( 1.0 - i.uv_texcoord.y ) + (-2.0 + (staticSwitch75 - 0.0) * (2.0 - -2.0) / (1.0 - 0.0)) ) - 0.0) * (1.0 - 0.0) / (1.0 - 0.0));
			float temp_output_10_0 = step( 0.1 , temp_output_13_0 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV68 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode68 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV68, _Fresnel_Power ) );
			o.Emission = ( ( float4( desaturateVar33 , 0.0 ) * _Emi_Color ) + ( _Edge_Color * ( temp_output_10_0 - step( _Edge_Range , temp_output_13_0 ) ) ) + ( saturate( fresnelNode68 ) * _Fresnel_Color ) ).rgb;
			o.Alpha = temp_output_10_0;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1920;0;1920;1019;2786.038;205.6381;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;44;-3282.815,-69.40569;Float;False;Property;_Normal_Vpanner;Normal_Vpanner;20;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-3277.313,-149.2012;Float;False;Property;_Normal_Upanner;Normal_Upanner;19;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-3037.927,-150.577;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;40;-3136.983,-292.2832;Float;False;0;36;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;41;-2845.317,-252.3852;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-2460.368,-377.0318;Float;False;Property;_Emi_Vpanner;Emi_Vpanner;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-2455.866,-456.8275;Float;False;Property;_Emi_Upanner;Emi_Upanner;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;36;-2606.212,-284.9677;Float;True;Property;_NormalTex;NormalTex;17;0;Create;True;0;0;False;0;51fe2c9d5b236124d9f9e7ea528b0bea;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;37;-2275.563,-283.9318;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-2372.563,-78.93166;Float;False;Property;_Distortion;Distortion;18;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;47;-2215.479,-458.2033;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-2439.733,188.4169;Float;False;Property;_Noise_Upanner;Noise_Upanner;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2445.235,268.2126;Float;False;Property;_Noise_Vpanner;Noise_Vpanner;14;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-2314.535,-599.9094;Float;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;52;-2200.346,187.0412;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1981.688,-279.817;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;51;-2299.402,45.33509;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;45;-2022.87,-560.0114;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-1785.96,-548.1793;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;50;-2007.736,85.23296;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;76;-2180.038,487.3619;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-2235.8,323.3;Float;False;Property;_Dissolve;Dissolve;12;0;Create;True;0;0;False;0;0.4;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1319.909,-406.8392;Float;False;Property;_Emi_Offset;Emi_Offset;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-1605.644,-571.8284;Float;True;Property;_EmiTex;EmiTex;1;0;Create;True;0;0;False;0;f6a0533931b7da14584952757e0eb640;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;75;-1882.038,324.3619;Float;False;Property;_USE_Custom;USE_Custom;25;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1677.8,155.3;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-1750.06,515.3055;Float;False;Constant;_Float4;Float 4;4;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1758.06,427.3055;Float;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;False;0;-2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-1814.852,-94.16958;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;16;-1497.06,324.3055;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1656.673,-107.6937;Float;True;Property;_NoiseTex;NoiseTex;11;0;Create;True;0;0;False;0;6e5343f0266cf36489aa21b41e5bc1f7;6e5343f0266cf36489aa21b41e5bc1f7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;5;-1426.8,202.3;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;24;-1133.272,-566.6117;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;28;-955.1183,-566.6111;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-933.9099,-412.4949;Float;False;Property;_Emi_Range;Emi_Range;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-1217.8,177.3;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-1302.457,998.0174;Float;False;Property;_Vertex_Vpanner;Vertex_Vpanner;24;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-1305.057,894.0172;Float;False;Property;_Vertex_Upanner;Vertex_Upanner;23;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1060.06,401.3055;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1050.06,500.3055;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-806.5671,-940.2993;Float;False;Property;_Fresnel_Scale;Fresnel_Scale;10;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;65;-1043.757,912.2174;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-755,-98.5;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-785.4481,-563.784;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-866.9034,414.2972;Float;False;Property;_Edge_Range;Edge_Range;15;0;Create;True;0;0;False;0;0.2451571;0;0.1;0.8;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;-851.0596,179.3055;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-1115.257,762.7173;Float;False;0;57;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;-805.5671,-838.2993;Float;False;Property;_Fresnel_Power;Fresnel_Power;9;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;11;-575.8,422.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;29;-622.6061,-566.7836;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;10;-585,23.5;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;68;-557.7366,-1005.621;Float;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-705.9874,-444.3294;Float;False;Property;_Desaturate;Desaturate;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;64;-835.7568,801.717;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;20;-298.2772,240.5961;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;71;-300.5667,-1002.299;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;32;-440.9874,-778.3295;Float;False;Property;_Emi_Color;Emi_Color;2;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;73;-383.5619,-1240.46;Float;False;Property;_Fresnel_Color;Fresnel_Color;8;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;-412.6566,1002.117;Float;False;Property;_Vertex_Normal_Str;Vertex_Normal_Str;22;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;33;-414.9872,-562.3295;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;57;-609.5563,797.8173;Float;True;Property;_VertexTex;VertexTex;21;0;Create;True;0;0;False;0;6e5343f0266cf36489aa21b41e5bc1f7;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;22;-430.2894,-263.7016;Float;False;Property;_Edge_Color;Edge_Color;16;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;58;-262.4563,500.1175;Float;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-181.9872,-559.3295;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-86.27722,-101.4039;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-118.2563,833.1172;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-147.2667,-1004.8;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;75.42929,505.0671;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;69.35438,-409.0793;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;357,-146;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS/27week/FX_WaterBall;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;42;0;43;0
WireConnection;42;1;44;0
WireConnection;41;0;40;0
WireConnection;41;2;42;0
WireConnection;36;1;41;0
WireConnection;37;0;36;0
WireConnection;47;0;48;0
WireConnection;47;1;49;0
WireConnection;52;0;53;0
WireConnection;52;1;54;0
WireConnection;38;0;37;0
WireConnection;38;1;39;0
WireConnection;45;0;46;0
WireConnection;45;2;47;0
WireConnection;55;0;45;0
WireConnection;55;1;38;0
WireConnection;50;0;51;0
WireConnection;50;2;52;0
WireConnection;23;1;55;0
WireConnection;75;1;8;0
WireConnection;75;0;76;3
WireConnection;56;0;38;0
WireConnection;56;1;50;0
WireConnection;16;0;75;0
WireConnection;16;3;17;0
WireConnection;16;4;18;0
WireConnection;1;1;56;0
WireConnection;5;0;3;2
WireConnection;24;0;23;0
WireConnection;24;1;25;0
WireConnection;28;0;24;0
WireConnection;7;0;1;1
WireConnection;7;1;5;0
WireConnection;7;2;16;0
WireConnection;65;0;66;0
WireConnection;65;1;67;0
WireConnection;26;0;28;0
WireConnection;26;1;27;0
WireConnection;13;0;7;0
WireConnection;13;3;14;0
WireConnection;13;4;15;0
WireConnection;11;0;19;0
WireConnection;11;1;13;0
WireConnection;29;0;26;0
WireConnection;10;0;12;0
WireConnection;10;1;13;0
WireConnection;68;2;69;0
WireConnection;68;3;70;0
WireConnection;64;0;63;0
WireConnection;64;2;65;0
WireConnection;20;0;10;0
WireConnection;20;1;11;0
WireConnection;71;0;68;0
WireConnection;33;0;29;0
WireConnection;33;1;34;0
WireConnection;57;1;64;0
WireConnection;31;0;33;0
WireConnection;31;1;32;0
WireConnection;21;0;22;0
WireConnection;21;1;20;0
WireConnection;60;0;57;1
WireConnection;60;1;62;0
WireConnection;72;0;71;0
WireConnection;72;1;73;0
WireConnection;74;0;58;0
WireConnection;74;1;60;0
WireConnection;35;0;31;0
WireConnection;35;1;21;0
WireConnection;35;2;72;0
WireConnection;0;2;35;0
WireConnection;0;9;10;0
WireConnection;0;11;74;0
ASEEND*/
//CHKSM=FD71CFD1DF821611178089885329A5ECBE42C1F2