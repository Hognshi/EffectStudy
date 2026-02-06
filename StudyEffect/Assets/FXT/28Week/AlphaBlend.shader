// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SBS/Amplify Shader/28Week/AlphaBlend"
{
	Properties
	{
		_MaskTex("MaskTex", 2D) = "white" {}
		_Opacity("Opacity", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform sampler2D _MaskTex;
		uniform float4 _MaskTex_ST;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color17 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			o.Emission = ( color17 * i.vertexColor ).rgb;
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			o.Alpha = ( i.vertexColor.a * saturate( ( tex2D( _MaskTex, uv_MaskTex ).r * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
735;1132;1498;1035;1266.266;1061.124;1.465017;True;False
Node;AmplifyShaderEditor.SamplerNode;11;-761.819,-316.0276;Float;True;Property;_MaskTex;MaskTex;1;0;Create;True;0;0;False;0;e58a863ab4b7cab4b84ccf6fb0966867;e58a863ab4b7cab4b84ccf6fb0966867;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-461.7726,-1.430257;Float;False;Property;_Opacity;Opacity;2;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-250.9047,-283.3644;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;16;-84.30714,-281.0344;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;12;-111.104,-525.6869;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;-149.2028,-718.1891;Float;False;Constant;_Tint_Color;Tint_Color;3;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;100.9306,-317.1497;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;128.4293,-549.8341;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;420.5116,-509.1093;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;SBS/Amplify Shader/28Week/AlphaBlend;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;False;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;11;1
WireConnection;14;1;15;0
WireConnection;16;0;14;0
WireConnection;13;0;12;4
WireConnection;13;1;16;0
WireConnection;18;0;17;0
WireConnection;18;1;12;0
WireConnection;2;2;18;0
WireConnection;2;9;13;0
ASEEND*/
//CHKSM=C2D85FBFF0E222C931278FDAECE964460B5E40B5