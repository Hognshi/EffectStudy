// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HomwWork/Projectile/Head_Highlight/Alp"
{
	Properties
	{
		_GradationTex("GradationTex", 2D) = "white" {}
		_ColorPower("ColorPower", Float) = 1
		_ColorIns("ColorIns", Float) = 0
		_FXT_Projectile_Head("FXT_Projectile_Head", 2D) = "white" {}
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

		uniform sampler2D _GradationTex;
		uniform float4 _GradationTex_ST;
		uniform float _ColorPower;
		uniform float _ColorIns;
		uniform sampler2D _FXT_Projectile_Head;
		uniform float4 _FXT_Projectile_Head_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color8 = IsGammaSpace() ? float4(0.9843138,0.9921569,0.7490196,1) : float4(0.9646866,0.9822509,0.5209957,1);
			float4 color9 = IsGammaSpace() ? float4(0.9686275,0.5529412,0.4588236,1) : float4(0.9301112,0.2663557,0.1778885,1);
			float2 uv_GradationTex = i.uv_texcoord * _GradationTex_ST.xy + _GradationTex_ST.zw;
			float4 lerpResult10 = lerp( color8 , color9 , saturate( ( saturate( pow( tex2D( _GradationTex, uv_GradationTex ).r , _ColorPower ) ) * _ColorIns ) ));
			o.Emission = ( lerpResult10 * i.vertexColor ).rgb;
			float2 uv_FXT_Projectile_Head = i.uv_texcoord * _FXT_Projectile_Head_ST.xy + _FXT_Projectile_Head_ST.zw;
			float4 tex2DNode13 = tex2D( _FXT_Projectile_Head, uv_FXT_Projectile_Head );
			o.Alpha = ( i.vertexColor.a * tex2DNode13.r );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
674;202;1830;1169;1390.112;137.3408;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-1251.063,186.1339;Float;True;Property;_GradationTex;GradationTex;1;0;Create;True;0;0;False;0;0964f63808cad004dafaaf75fe572bbd;0964f63808cad004dafaaf75fe572bbd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-1114.562,-55.66666;Float;False;Property;_ColorPower;ColorPower;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;4;-942.9624,191.3332;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-777.8629,-51.76674;Float;False;Property;_ColorIns;ColorIns;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;5;-676.4626,190.0332;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-474.9629,190.0332;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;7;-235.7622,191.3335;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-918.2648,-279.2657;Float;False;Constant;_Color1;Color 1;4;0;Create;True;0;0;False;0;0.9686275,0.5529412,0.4588236,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-919.5654,-452.1658;Float;False;Constant;_Color0;Color 0;4;0;Create;True;0;0;False;0;0.9843138,0.9921569,0.7490196,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;14;-174.8703,-33.93119;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;10;-439.8651,-413.1661;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;13;-766.1954,483.5568;Float;True;Property;_FXT_Projectile_Head;FXT_Projectile_Head;6;0;Create;True;0;0;False;0;799f3cb560952cc4ca048de6a9029858;c192320c5c855a7488f4354feb71bc1e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;151.4301,-59.93121;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-494.1214,845.8408;Float;False;Property;_Main_Power;Main_Power;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-213.189,902.1855;Float;False;Property;_Main_Ins;Main_Ins;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;19;-330.1512,679.2913;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;15.43639,680.845;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;306.659,452.1583;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;477.1,-28.6;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;HomwWork/Projectile/Head_Highlight/Alp;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;1
WireConnection;4;1;2;0
WireConnection;5;0;4;0
WireConnection;6;0;5;0
WireConnection;6;1;3;0
WireConnection;7;0;6;0
WireConnection;10;0;8;0
WireConnection;10;1;9;0
WireConnection;10;2;7;0
WireConnection;15;0;10;0
WireConnection;15;1;14;0
WireConnection;19;0;13;1
WireConnection;19;1;17;0
WireConnection;20;0;19;0
WireConnection;20;1;18;0
WireConnection;16;0;14;4
WireConnection;16;1;13;1
WireConnection;0;2;15;0
WireConnection;0;9;16;0
ASEEND*/
//CHKSM=782450DE5025D630FECF69C2DE1F7F4B443C9AEC