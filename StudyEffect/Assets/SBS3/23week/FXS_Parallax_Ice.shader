// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS3/23week/FX_Parallax_Ice"
{
	Properties
	{
		_Main_Power("Main_Power", Float) = 1
		_MainTex("MainTex", 2D) = "white" {}
		_Main_Ins("Main_Ins", Float) = 1
		_MaskTex("MaskTex", 2D) = "white" {}
		_Opacity("Opacity", Float) = 1
		_Texture("Texture", 2D) = "white" {}
		_Parallax_Offset("Parallax_Offset", Float) = 0
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
			float3 viewDir;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _MainTex;
		uniform sampler2D _Texture;
		uniform float4 _Texture_ST;
		uniform float _Parallax_Offset;
		uniform float _Main_Power;
		uniform float _Main_Ins;
		uniform sampler2D _MaskTex;
		uniform float _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv_Texture = i.uv_texcoord * _Texture_ST.xy + _Texture_ST.zw;
			float Parallax_Offset38 = _Parallax_Offset;
			float3 View_Dir46 = i.viewDir;
			float2 Offset21 = ( ( tex2D( _Texture, uv_Texture ).r - 1 ) * View_Dir46.xy * Parallax_Offset38 ) + i.uv_texcoord;
			float2 Offset28 = ( ( tex2D( _Texture, Offset21 ).r - 1 ) * View_Dir46.xy * Parallax_Offset38 ) + Offset21;
			float2 Offset29 = ( ( tex2D( _Texture, Offset28 ).r - 1 ) * View_Dir46.xy * Parallax_Offset38 ) + Offset28;
			float2 Offset30 = ( ( tex2D( _Texture, Offset29 ).r - 1 ) * View_Dir46.xy * Parallax_Offset38 ) + Offset29;
			float2 Offset31 = ( ( tex2D( _Texture, Offset30 ).r - 1 ) * View_Dir46.xy * Parallax_Offset38 ) + Offset30;
			float2 Offset32 = ( ( tex2D( _Texture, Offset31 ).r - 1 ) * View_Dir46.xy * Parallax_Offset38 ) + Offset31;
			float2 Parallax_UV69 = Offset32;
			float4 temp_cast_0 = (_Main_Power).xxxx;
			o.Emission = ( ( pow( tex2D( _MainTex, Parallax_UV69 ) , temp_cast_0 ) * _Main_Ins ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor.a * saturate( ( tex2D( _MaskTex, Parallax_UV69 ).r * _Opacity ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-63;374;1920;959;2763.2;-750.9897;1.340836;True;False
Node;AmplifyShaderEditor.RangedFloatNode;25;-4438.716,-1212.789;Float;False;Property;_Parallax_Offset;Parallax_Offset;7;0;Create;True;0;0;False;0;0;-0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;26;-4426.362,-1087.248;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;68;-4777.674,-864.2762;Float;False;777.4592;2791.572;Comment;40;21;23;22;27;28;54;41;48;33;56;58;57;42;49;29;34;30;61;60;59;43;50;35;44;51;62;63;64;36;31;65;66;67;45;52;32;40;47;53;55;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;38;-4222.519,-1212.719;Float;False;Parallax_Offset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;-4216.289,-1087.352;Float;False;View_Dir;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;20;-5124.844,537.0883;Float;True;Property;_Texture;Texture;6;0;Create;True;0;0;False;0;None;a56e7ebe1a76f3d4eb12a399ad8c81f2;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-4678.211,-814.2762;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-4727.674,-665.7684;Float;True;Property;_TextureSample0;Texture Sample 0;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;40;-4622.383,-460.2359;Float;False;38;Parallax_Offset;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-4596.571,-369.2738;Float;False;46;View_Dir;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ParallaxMappingNode;21;-4298.128,-662.8485;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;55;-4062.213,-323.3419;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;54;-4082.213,-284.3419;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;53;-4691.215,-276.3419;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;48;-4597.085,87.74171;Float;False;46;View_Dir;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;27;-4667.268,-203.5126;Float;True;Property;_TextureSample1;Texture Sample 1;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;41;-4607.697,9.285639;Float;False;38;Parallax_Offset;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;28;-4315.924,-157.4915;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;58;-4132.339,140.1753;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;57;-4173.982,184.9443;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;56;-4677.904,204.7266;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;-4595.355,521.7509;Float;False;46;View_Dir;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;33;-4670.57,249.1558;Float;True;Property;_TextureSample2;Texture Sample 2;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;42;-4615.667,440.3176;Float;False;38;Parallax_Offset;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;29;-4304.522,300.6123;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;61;-4095.2,557.1506;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;60;-4147.58,622.6224;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;59;-4693.8,613.2693;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;34;-4666.789,673.6499;Float;True;Property;_TextureSample3;Texture Sample 3;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;50;-4563.334,954.8131;Float;False;46;View_Dir;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-4589.393,872.6675;Float;False;38;Parallax_Offset;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;30;-4335.05,718.048;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;64;-4143.64,1004.678;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;63;-4170.671,1041.672;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;62;-4702.803,1077.242;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-4569.959,1389.849;Float;False;46;View_Dir;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-4594.101,1298.883;Float;False;38;Parallax_Offset;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;35;-4681.588,1098.237;Float;True;Property;_TextureSample4;Texture Sample 4;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;31;-4318.089,1171.567;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;67;-4084.024,1404.751;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;66;-4128.854,1443.979;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;65;-4719.167,1483.209;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-4580.772,1729.744;Float;False;38;Parallax_Offset;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;36;-4680.088,1514.908;Float;True;Property;_TextureSample5;Texture Sample 5;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;52;-4551.673,1811.296;Float;False;46;View_Dir;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ParallaxMappingNode;32;-4302.782,1607.757;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;-3946.197,1609.964;Float;False;Parallax_UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;-1662.755,830.2424;Float;False;69;Parallax_UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;9;-1226.451,1299.33;Float;True;Property;_MaskTex;MaskTex;4;0;Create;True;0;0;False;0;c881db00c19331f40ba44708fb7b3c43;c881db00c19331f40ba44708fb7b3c43;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1122.206,985.068;Float;False;Property;_Main_Power;Main_Power;1;0;Create;True;0;0;False;0;1;3.37;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-994.3427,1554.418;Float;False;Property;_Opacity;Opacity;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1413.207,806.0681;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;a56e7ebe1a76f3d4eb12a399ad8c81f2;a56e7ebe1a76f3d4eb12a399ad8c81f2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-830.0298,1329.206;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;3;-959.2065,833.0681;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-852.2065,975.068;Float;False;Property;_Main_Ins;Main_Ins;3;0;Create;True;0;0;False;0;1;2.78;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;12;-676.058,1274.052;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;7;-694.1197,1028.15;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-676.2065,832.0681;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-519.7875,1176.383;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-520.5524,916.7891;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-343.3078,950.2025;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;Amplify Shader/SBS3/23week/FX_Parallax_Ice;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;25;0
WireConnection;46;0;26;0
WireConnection;23;0;20;0
WireConnection;21;0;22;0
WireConnection;21;1;23;1
WireConnection;21;2;40;0
WireConnection;21;3;47;0
WireConnection;55;0;21;0
WireConnection;54;0;55;0
WireConnection;53;0;54;0
WireConnection;27;0;20;0
WireConnection;27;1;53;0
WireConnection;28;0;21;0
WireConnection;28;1;27;1
WireConnection;28;2;41;0
WireConnection;28;3;48;0
WireConnection;58;0;28;0
WireConnection;57;0;58;0
WireConnection;56;0;57;0
WireConnection;33;0;20;0
WireConnection;33;1;56;0
WireConnection;29;0;28;0
WireConnection;29;1;33;1
WireConnection;29;2;42;0
WireConnection;29;3;49;0
WireConnection;61;0;29;0
WireConnection;60;0;61;0
WireConnection;59;0;60;0
WireConnection;34;0;20;0
WireConnection;34;1;59;0
WireConnection;30;0;29;0
WireConnection;30;1;34;1
WireConnection;30;2;43;0
WireConnection;30;3;50;0
WireConnection;64;0;30;0
WireConnection;63;0;64;0
WireConnection;62;0;63;0
WireConnection;35;0;20;0
WireConnection;35;1;62;0
WireConnection;31;0;30;0
WireConnection;31;1;35;1
WireConnection;31;2;44;0
WireConnection;31;3;51;0
WireConnection;67;0;31;0
WireConnection;66;0;67;0
WireConnection;65;0;66;0
WireConnection;36;0;20;0
WireConnection;36;1;65;0
WireConnection;32;0;31;0
WireConnection;32;1;36;1
WireConnection;32;2;45;0
WireConnection;32;3;52;0
WireConnection;69;0;32;0
WireConnection;9;1;70;0
WireConnection;1;1;70;0
WireConnection;10;0;9;1
WireConnection;10;1;11;0
WireConnection;3;0;1;0
WireConnection;3;1;4;0
WireConnection;12;0;10;0
WireConnection;5;0;3;0
WireConnection;5;1;6;0
WireConnection;13;0;7;4
WireConnection;13;1;12;0
WireConnection;8;0;5;0
WireConnection;8;1;7;0
WireConnection;0;2;8;0
WireConnection;0;9;13;0
ASEEND*/
//CHKSM=B50416FE6A0BF3D4DACFDDF473E6C9BC4842E182