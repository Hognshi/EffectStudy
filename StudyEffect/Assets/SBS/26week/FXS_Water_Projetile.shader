// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/26week/FX_Water_Projectile"
{
	Properties
	{
		[HDR]_Noise_Color("Noise_Color", Color) = (1,1,1,0)
		_Color_A("Color_A", Color) = (0.01198876,0,0.3396226,0)
		[HDR]_Color_B("Color_B", Color) = (0,0.2637056,0.8773585,0)
		_Color_Range("Color_Range", Float) = 1
		_Color_Offset("Color_Offset", Float) = 1
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_Noise_Upanner("Noise_Upanner", Float) = 0
		_Noise_Vpanner("Noise_Vpanner", Float) = 0
		_Noise_Power("Noise_Power", Float) = 1
		_Noise_Ins("Noise_Ins", Float) = 1
		_NormalTex("NormalTex", 2D) = "bump" {}
		_Normal_Upanner("Normal_Upanner", Float) = 0
		_Normal_Vpanner("Normal_Vpanner", Float) = 0
		_Distortion("Distortion", Range( 0 , 1)) = 0
		_MaskTex("MaskTex", 2D) = "white" {}
		[Toggle(_USE_CUSTOM_ON)] _USE_Custom("USE_Custom", Float) = 0
		[Toggle(_USE_GRADATIONTEX_ON)] _USE_GradationTex("USE_GradationTex", Float) = 0
		_GradationTex("GradationTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _USE_CUSTOM_ON
		#pragma shader_feature _USE_GRADATIONTEX_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
		};

		uniform float4 _Color_A;
		uniform float4 _Color_B;
		uniform float _Color_Offset;
		uniform float _Color_Range;
		uniform sampler2D _NoiseTex;
		uniform float _Noise_Upanner;
		uniform float _Noise_Vpanner;
		uniform float4 _NoiseTex_ST;
		uniform sampler2D _NormalTex;
		uniform float _Normal_Upanner;
		uniform float _Normal_Vpanner;
		uniform float4 _NormalTex_ST;
		uniform float _Distortion;
		uniform float _Noise_Power;
		uniform float _Noise_Ins;
		uniform float4 _Noise_Color;
		uniform sampler2D _MaskTex;
		uniform float4 _MaskTex_ST;
		uniform sampler2D _GradationTex;
		uniform float4 _GradationTex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 lerpResult34 = lerp( _Color_A , _Color_B , saturate( ( saturate( pow( ( 1.0 - i.uv_texcoord.x ) , _Color_Offset ) ) * _Color_Range ) ));
			float2 appendResult44 = (float2(_Noise_Upanner , _Noise_Vpanner));
			float2 uv0_NoiseTex = i.uv_texcoord * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			float2 panner42 = ( 1.0 * _Time.y * appendResult44 + uv0_NoiseTex);
			float2 appendResult8 = (float2(_Normal_Upanner , _Normal_Vpanner));
			float2 uv0_NormalTex = i.uv_texcoord * _NormalTex_ST.xy + _NormalTex_ST.zw;
			float2 panner7 = ( 1.0 * _Time.y * appendResult8 + uv0_NormalTex);
			float2 temp_output_12_0 = ( (UnpackNormal( tex2D( _NormalTex, panner7 ) )).xy * _Distortion );
			o.Emission = ( ( lerpResult34 + ( ( pow( tex2D( _NoiseTex, ( panner42 + temp_output_12_0 ) ).r , _Noise_Power ) * _Noise_Ins ) * _Noise_Color ) ) * i.vertexColor ).rgb;
			float2 uv0_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			float2 appendResult56 = (float2(( uv0_MaskTex.x + i.uv_tex4coord.z ) , uv0_MaskTex.y));
			#ifdef _USE_CUSTOM_ON
				float2 staticSwitch57 = appendResult56;
			#else
				float2 staticSwitch57 = uv0_MaskTex;
			#endif
			float2 uv_GradationTex = i.uv_texcoord * _GradationTex_ST.xy + _GradationTex_ST.zw;
			#ifdef _USE_GRADATIONTEX_ON
				float staticSwitch58 = tex2D( _GradationTex, uv_GradationTex ).r;
			#else
				float staticSwitch58 = saturate( ( saturate( pow( ( 1.0 - ( i.uv_texcoord.x + 0.0 ) ) , 3.0 ) ) * 5.0 ) );
			#endif
			o.Alpha = ( i.vertexColor.a * saturate( ( tex2D( _MaskTex, ( temp_output_12_0 + staticSwitch57 ) ).r * staticSwitch58 ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
790;577;1081;642;1605.928;18.48981;1.54073;True;False
Node;AmplifyShaderEditor.RangedFloatNode;10;-1548.525,128.3565;Float;False;Property;_Normal_Vpanner;Normal_Vpanner;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1550.525,42.35649;Float;False;Property;_Normal_Upanner;Normal_Upanner;12;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1311.525,45.35649;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1384.525,-98.64352;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1258.407,790.2029;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;7;-1125.525,-51.64351;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;5;-910.5245,-78.64352;Float;True;Property;_NormalTex;NormalTex;11;0;Create;True;0;0;False;0;645b0a2fda25d114599a2fba6417fe81;51fe2c9d5b236124d9f9e7ea528b0bea;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;-767.0057,-388.5341;Float;False;Property;_Noise_Vpanner;Noise_Vpanner;8;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-762.9176,-467.5738;Float;False;Property;_Noise_Upanner;Noise_Upanner;7;0;Create;True;0;0;False;0;0;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1005.408,813.2029;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-711.4076,1048.203;Float;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-761.4076,810.2029;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1148.6,257.8;Float;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;55;-1142.502,434.3382;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-917.68,-1083.413;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;11;-573.0735,-77.81013;Float;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-625.2795,-640.6431;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-650.7588,150.0546;Float;False;Property;_Distortion;Distortion;14;0;Create;True;0;0;False;0;0;0.102;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;44;-548.9647,-478.4759;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;18;-552.4077,809.2029;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-292.7585,139.0546;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;42;-347.2772,-565.6917;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-586.2421,-835.2109;Float;False;Property;_Color_Offset;Color_Offset;5;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;27;-636.2422,-1057.814;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-839.5022,399.3382;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;56;-689.5022,404.3382;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-322.4075,1007.203;Float;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;20;-304.4075,809.2029;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;29;-427.2418,-1058.814;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-137.4129,-561.6041;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;48;129.6873,-370.8183;Float;False;Property;_Noise_Power;Noise_Power;9;0;Create;True;0;0;False;0;1;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;30;-179.2416,-1058.814;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;9.576822,-588.9404;Float;True;Property;_NoiseTex;NoiseTex;6;0;Create;True;0;0;False;0;c7d564bbc661feb448e7dcb86e2aa438;c7d564bbc661feb448e7dcb86e2aa438;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;32;-216.8382,-844.0166;Float;False;Property;_Color_Range;Color_Range;4;0;Create;True;0;0;False;0;1;1.57;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;57;-513.5022,312.3382;Float;False;Property;_USE_Custom;USE_Custom;16;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-161.4074,795.2029;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-20.84448,-1058.816;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;330.0124,-374.9065;Float;False;Property;_Noise_Ins;Noise_Ins;10;0;Create;True;0;0;False;0;1;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;47;331.3751,-558.8785;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;62.91742,718.7449;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-75.80248,273.3498;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;59;-95.94377,1139.643;Float;True;Property;_GradationTex;GradationTex;18;0;Create;True;0;0;False;0;None;e1860fa4f6629ef4489700f06904f8de;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;52;406.3268,-781.0072;Float;False;Property;_Noise_Color;Noise_Color;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0.4339623,0.4339623,0.4339623,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;58;281.6011,714.6239;Float;False;Property;_USE_GradationTex;USE_GradationTex;17;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;33;222.581,-1062.279;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;-22.80509,-1481.896;Float;False;Property;_Color_A;Color_A;2;0;Create;True;0;0;False;0;0.01198876,0,0.3396226,0;0.1664601,0.1521894,0.5660378,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;36;-15.97554,-1274.278;Float;False;Property;_Color_B;Color_B;3;1;[HDR];Create;True;0;0;False;0;0,0.2637056,0.8773585,0;0.4669811,0.6278057,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;160.2369,246.8846;Float;True;Property;_MaskTex;MaskTex;15;0;Create;True;0;0;False;0;009a995d3861b9147b0a93951eac33fe;93024de2c849bde4eb285c4c7d22ded1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;490.8174,-558.8784;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;34;378.5001,-1293.556;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;631.1813,-564.3292;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;513.4044,269.7975;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;787.5605,-799.1677;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;39;641.3026,-213.5706;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;40;725.7004,131.8743;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;878.7954,-50.66195;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;884.6837,-333.2986;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1060.067,-281.5772;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS/26week/FX_Water_Projectile;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;9;0
WireConnection;8;1;10;0
WireConnection;7;0;6;0
WireConnection;7;2;8;0
WireConnection;5;1;7;0
WireConnection;16;0;15;1
WireConnection;17;0;16;0
WireConnection;11;0;5;0
WireConnection;44;0;45;0
WireConnection;44;1;46;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;12;0;11;0
WireConnection;12;1;13;0
WireConnection;42;0;41;0
WireConnection;42;2;44;0
WireConnection;27;0;25;1
WireConnection;54;0;3;1
WireConnection;54;1;55;3
WireConnection;56;0;54;0
WireConnection;56;1;3;2
WireConnection;20;0;18;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;43;0;42;0
WireConnection;43;1;12;0
WireConnection;30;0;29;0
WireConnection;2;1;43;0
WireConnection;57;1;3;0
WireConnection;57;0;56;0
WireConnection;21;0;20;0
WireConnection;21;1;22;0
WireConnection;31;0;30;0
WireConnection;31;1;32;0
WireConnection;47;0;2;1
WireConnection;47;1;48;0
WireConnection;23;0;21;0
WireConnection;4;0;12;0
WireConnection;4;1;57;0
WireConnection;58;1;23;0
WireConnection;58;0;59;1
WireConnection;33;0;31;0
WireConnection;1;1;4;0
WireConnection;49;0;47;0
WireConnection;49;1;50;0
WireConnection;34;0;35;0
WireConnection;34;1;36;0
WireConnection;34;2;33;0
WireConnection;51;0;49;0
WireConnection;51;1;52;0
WireConnection;14;0;1;1
WireConnection;14;1;58;0
WireConnection;53;0;34;0
WireConnection;53;1;51;0
WireConnection;40;0;14;0
WireConnection;38;0;39;4
WireConnection;38;1;40;0
WireConnection;37;0;53;0
WireConnection;37;1;39;0
WireConnection;0;2;37;0
WireConnection;0;9;38;0
ASEEND*/
//CHKSM=E0098A2CFFADEC47D398D8E0D9D3B28FEC235CC1