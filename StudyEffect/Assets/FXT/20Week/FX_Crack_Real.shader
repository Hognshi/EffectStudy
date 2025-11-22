// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/20Week/FX_Crack_Real"
{
	Properties
	{
		_BaseTex("BaseTex", 2D) = "white" {}
		_FXT_Crack_Noise("FXT_Crack_Noise", 2D) = "white" {}
		_Opacity("Opacity", Float) = 1
		_EmiPower("EmiPower", Float) = 7.87
		[HDR]_EmiColor("EmiColor", Color) = (1,0,0,0)
		[HDR]_BaseColor("BaseColor", Color) = (0.509434,0.1366631,0,0)
		_NormalTex("NormalTex", 2D) = "bump" {}
		_NormalIns("Normal Ins", Float) = 1
		_BumpTex("BumpTex", 2D) = "white" {}
		_ParallaxOffset("ParallaxOffset", Range( -0.1 , 0.1)) = 0
		_NosieTex("NosieTex", 2D) = "white" {}
		_NoiseIns("NoiseIns", Float) = 3.58
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform float _NormalIns;
		uniform sampler2D _NormalTex;
		uniform float4 _NormalTex_ST;
		uniform sampler2D _BaseTex;
		uniform sampler2D _BumpTex;
		uniform float4 _BumpTex_ST;
		uniform float _ParallaxOffset;
		uniform float4 _BaseColor;
		uniform float _EmiPower;
		uniform sampler2D _NosieTex;
		uniform float4 _NosieTex_ST;
		uniform float _NoiseIns;
		uniform float4 _EmiColor;
		uniform sampler2D _FXT_Crack_Noise;
		uniform float4 _FXT_Crack_Noise_ST;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _NormalTex, uv_NormalTex ), _NormalIns );
			float2 uv_BumpTex = i.uv_texcoord * _BumpTex_ST.xy + _BumpTex_ST.zw;
			float2 paralaxOffset22 = ParallaxOffset( tex2D( _BumpTex, uv_BumpTex ).r , _ParallaxOffset , i.viewDir );
			float4 tex2DNode1 = tex2D( _BaseTex, ( i.uv_texcoord + paralaxOffset22 ) );
			o.Albedo = ( tex2DNode1 * _BaseColor ).rgb;
			float2 temp_cast_1 = (0.5).xx;
			float temp_output_14_0 = pow( ( ( 1.0 - length( ( i.uv_texcoord - temp_cast_1 ) ) ) * ( 1.0 - tex2DNode1.r ) ) , _EmiPower );
			float2 uv0_NosieTex = i.uv_texcoord * _NosieTex_ST.xy + _NosieTex_ST.zw;
			float2 panner33 = ( 1.0 * _Time.y * float2( 0.03,0.03 ) + uv0_NosieTex);
			float2 appendResult42 = (float2(uv0_NosieTex.x , ( uv0_NosieTex.y + 0.5 )));
			float2 panner34 = ( 1.0 * _Time.y * float2( -0.03,-0.03 ) + appendResult42);
			o.Emission = ( temp_output_14_0 * ( ( ( tex2D( _NosieTex, panner33 ).r * tex2D( _NosieTex, panner34 ).a ) * _NoiseIns ) + saturate( temp_output_14_0 ) ) * _EmiColor ).rgb;
			float2 uv_FXT_Crack_Noise = i.uv_texcoord * _FXT_Crack_Noise_ST.xy + _FXT_Crack_Noise_ST.zw;
			o.Alpha = saturate( ( tex2D( _FXT_Crack_Noise, uv_FXT_Crack_Noise ).r * _Opacity ) );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
714;592;1498;1102;1819.966;1020.333;1;True;False
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;28;-1666.002,422.6479;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;27;-1770.949,321.4019;Float;False;Property;_ParallaxOffset;ParallaxOffset;10;0;Create;True;0;0;False;0;0;0;-0.1;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;-1791.299,109.2205;Float;True;Property;_BumpTex;BumpTex;9;0;Create;True;0;0;False;0;7fc2022726983fd4986d8e27fcc8496f;7fc2022726983fd4986d8e27fcc8496f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-1400.009,-890.9766;Float;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-1439.299,-4.77948;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;44;-1493.966,-704.3331;Float;False;Constant;_Float2;Float 2;13;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-823.5195,-194.2369;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;22;-1412.299,171.2205;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-884.5195,-353.2369;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-1061.299,112.2205;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;11;-598.5195,-375.2369;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-1327.966,-742.3331;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-1187.966,-767.3331;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;12;-374.5195,-377.2369;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-704.4434,-49.35567;Float;True;Property;_BaseTex;BaseTex;1;0;Create;True;0;0;False;0;a2e8fe79f0785a547a4865b9c58e66f5;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;35;-1185.803,-1024.676;Float;False;Constant;_Vector0;Vector 0;12;0;Create;True;0;0;False;0;0.03,0.03;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;36;-1191.363,-654.0643;Float;False;Constant;_Vector1;Vector 1;12;0;Create;True;0;0;False;0;-0.03,-0.03;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;29;-641.7742,-846.691;Float;True;Property;_NosieTex;NosieTex;11;0;Create;True;0;0;False;0;1660e2c4f161d954fa8674aef3559472;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.PannerNode;34;-941.4089,-721.338;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;7;-247.2209,-121.1629;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;13;-238.5195,-412.2369;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;33;-951.4719,-924.0423;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-51.99533,-186.3238;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;30;-147.8446,-951.3568;Float;True;Property;_TextureSample0;Texture Sample 0;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-149.2822,-750.0905;Float;True;Property;_TextureSample1;Texture Sample 1;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;17.48047,-299.2369;Float;False;Property;_EmiPower;EmiPower;4;0;Create;True;0;0;False;0;7.87;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;14;218.4805,-317.2369;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;316.5333,-901.8206;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;466.6236,-1069.443;Float;False;Property;_NoiseIns;NoiseIns;12;0;Create;True;0;0;False;0;3.58;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-45.80719,375.783;Float;False;Property;_Opacity;Opacity;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;40;679.7728,-552.198;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;676.9308,-903.1864;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-203.5119,474.2538;Float;True;Property;_FXT_Crack_Noise;FXT_Crack_Noise;2;0;Create;True;0;0;False;0;2501e4ecfb5b5c749ad526597f3b4c2b;2501e4ecfb5b5c749ad526597f3b4c2b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;674.2543,-349.7006;Float;False;Property;_EmiColor;EmiColor;5;1;[HDR];Create;True;0;0;False;0;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;19;-153.1255,120.6926;Float;False;Property;_BaseColor;BaseColor;6;1;[HDR];Create;True;0;0;False;0;0.509434,0.1366631,0,0;0.509434,0.1366631,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;183.0907,489.1783;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-999.6472,374.575;Float;False;Property;_NormalIns;Normal Ins;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;1062.021,-805.1351;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;8.649701,-42.09995;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;20;-692.724,345.1061;Float;True;Property;_NormalTex;NormalTex;7;0;Create;True;0;0;False;0;fd9ed522eb627b24bb7271fdd2187903;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;1045.779,-479.0017;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;5;375.1928,487.783;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;192.8359,24.15634;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1224.824,-113.2434;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SBS/Amplify Shader/20Week/FX_Crack_Real;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;25;1
WireConnection;22;1;27;0
WireConnection;22;2;28;0
WireConnection;23;0;24;0
WireConnection;23;1;22;0
WireConnection;11;0;9;0
WireConnection;11;1;10;0
WireConnection;43;0;32;2
WireConnection;43;1;44;0
WireConnection;42;0;32;1
WireConnection;42;1;43;0
WireConnection;12;0;11;0
WireConnection;1;1;23;0
WireConnection;34;0;42;0
WireConnection;34;2;36;0
WireConnection;7;0;1;1
WireConnection;13;0;12;0
WireConnection;33;0;32;0
WireConnection;33;2;35;0
WireConnection;8;0;13;0
WireConnection;8;1;7;0
WireConnection;30;0;29;0
WireConnection;30;1;33;0
WireConnection;31;0;29;0
WireConnection;31;1;34;0
WireConnection;14;0;8;0
WireConnection;14;1;15;0
WireConnection;37;0;30;1
WireConnection;37;1;31;4
WireConnection;40;0;14;0
WireConnection;38;0;37;0
WireConnection;38;1;39;0
WireConnection;3;0;2;1
WireConnection;3;1;4;0
WireConnection;41;0;38;0
WireConnection;41;1;40;0
WireConnection;18;0;1;0
WireConnection;18;1;19;0
WireConnection;20;5;21;0
WireConnection;16;0;14;0
WireConnection;16;1;41;0
WireConnection;16;2;17;0
WireConnection;5;0;3;0
WireConnection;0;0;18;0
WireConnection;0;1;20;0
WireConnection;0;2;16;0
WireConnection;0;9;5;0
ASEEND*/
//CHKSM=27478A3E2E56825484FEE5889B7A4734364AD44B