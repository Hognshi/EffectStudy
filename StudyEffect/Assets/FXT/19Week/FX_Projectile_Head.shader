// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/19Week/FX_Projectile_Head"
{
	Properties
	{
		_GradationTex("GradationTex", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_ColorPower("ColorPower", Float) = 1
		[HDR]_Color_A("Color_A", Color) = (1,0,0,0)
		[HDR]_Color_B("Color_B", Color) = (0,0.809149,0.8490566,0)
		_ColorIns("ColorIns", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Color_A;
		uniform float4 _Color_B;
		uniform sampler2D _GradationTex;
		uniform float4 _GradationTex_ST;
		uniform float _ColorPower;
		uniform float _ColorIns;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_GradationTex = i.uv_texcoord * _GradationTex_ST.xy + _GradationTex_ST.zw;
			float4 lerpResult3 = lerp( _Color_A , _Color_B , saturate( ( saturate( pow( tex2D( _GradationTex, uv_GradationTex ).r , _ColorPower ) ) * _ColorIns ) ));
			o.Emission = ( lerpResult3 * i.vertexColor ).rgb;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * tex2D( _MainTex, uv_MainTex ).r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
557;184;1830;1187;1379.667;860.139;1.29629;True;False
Node;AmplifyShaderEditor.RangedFloatNode;9;-755.2408,-348.3657;Float;False;Property;_ColorPower;ColorPower;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-764.7995,-241.2892;Float;True;Property;_GradationTex;GradationTex;1;0;Create;True;0;0;False;0;0964f63808cad004dafaaf75fe572bbd;0964f63808cad004dafaaf75fe572bbd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;7;-432.535,-213.0388;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;10;-272.3435,-213.0534;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-411.2115,-303.4388;Float;False;Property;_ColorIns;ColorIns;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-65.76798,-214.3966;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-342.0197,-673.3148;Float;False;Property;_Color_A;Color_A;4;1;[HDR];Create;True;0;0;False;0;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-339.0197,-495.3148;Float;False;Property;_Color_B;Color_B;5;1;[HDR];Create;True;0;0;False;0;0,0.809149,0.8490566,0;0,0.809149,0.8490566,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;13;93.09705,-213.3696;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;3;298.1942,-503.9492;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;14;522.3359,-155.5675;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;401.2533,63.98108;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;b3b37e1da9c6e064d83acd3524347e44;b3b37e1da9c6e064d83acd3524347e44;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;767.3359,-156.5675;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;790.2794,69.37207;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1104.733,-268.3872;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/19Week/FX_Projectile_Head;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;1;1
WireConnection;7;1;9;0
WireConnection;10;0;7;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;13;0;11;0
WireConnection;3;0;4;0
WireConnection;3;1;5;0
WireConnection;3;2;13;0
WireConnection;16;0;3;0
WireConnection;16;1;14;0
WireConnection;17;0;14;4
WireConnection;17;1;2;1
WireConnection;0;2;16;0
WireConnection;0;9;17;0
ASEEND*/
//CHKSM=A79E6953B5562DC070D1B571975D553F55D8E5D2