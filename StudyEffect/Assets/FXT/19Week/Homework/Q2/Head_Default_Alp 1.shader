// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HomwWork/Projectile/Alp"
{
	Properties
	{
		_Main_Power("Main_Power", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
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
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform sampler2D _FXT_Projectile_Head;
		uniform float4 _FXT_Projectile_Head_ST;
		uniform float _Main_Power;
		uniform float _Main_Ins;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 color21 = IsGammaSpace() ? float4(0.5529412,0.4745098,0.854902,1) : float4(0.2663557,0.1912017,0.701102,1);
			o.Emission = ( color21 * i.vertexColor ).rgb;
			float2 uv_FXT_Projectile_Head = i.uv_texcoord * _FXT_Projectile_Head_ST.xy + _FXT_Projectile_Head_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( pow( tex2D( _FXT_Projectile_Head, uv_FXT_Projectile_Head ).r , _Main_Power ) * _Main_Ins ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
361;447;1261;924;1099.052;422.1379;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;17;-494.1214,845.8408;Float;False;Property;_Main_Power;Main_Power;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-766.1954,483.5568;Float;True;Property;_FXT_Projectile_Head;FXT_Projectile_Head;6;0;Create;True;0;0;False;0;c192320c5c855a7488f4354feb71bc1e;c192320c5c855a7488f4354feb71bc1e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-213.189,902.1855;Float;False;Property;_Main_Ins;Main_Ins;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;19;-330.1512,679.2913;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-615.3769,-284.4185;Float;False;Constant;_Color0;Color 0;7;0;Create;True;0;0;False;0;0.5529412,0.4745098,0.854902,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;14;-174.8703,-33.93119;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;15.43639,680.845;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-777.8629,-51.76674;Float;False;Property;_ColorIns;ColorIns;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;7;-235.7622,191.3335;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;306.659,452.1583;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;151.4301,-59.93121;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;5;-676.4626,190.0332;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;4;-942.9624,191.3332;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1114.562,-55.66666;Float;False;Property;_ColorPower;ColorPower;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-474.9629,190.0332;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1251.063,186.1339;Float;True;Property;_GradationTex;GradationTex;1;0;Create;True;0;0;False;0;0964f63808cad004dafaaf75fe572bbd;0964f63808cad004dafaaf75fe572bbd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;477.1,-28.6;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;HomwWork/Projectile/Alp;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;13;1
WireConnection;19;1;17;0
WireConnection;20;0;19;0
WireConnection;20;1;18;0
WireConnection;7;0;6;0
WireConnection;16;0;14;4
WireConnection;16;1;20;0
WireConnection;15;0;21;0
WireConnection;15;1;14;0
WireConnection;5;0;4;0
WireConnection;4;0;1;1
WireConnection;4;1;2;0
WireConnection;6;0;5;0
WireConnection;6;1;3;0
WireConnection;0;2;15;0
WireConnection;0;9;16;0
ASEEND*/
//CHKSM=D5DD7C14F7C4CBF045323328CC245AD6A7CFBC4E