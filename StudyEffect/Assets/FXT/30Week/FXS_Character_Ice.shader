// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/30Week/CharcaterFX_ICe"
{
	Properties
	{
		_Mutant_normal("Mutant_normal", 2D) = "bump" {}
		_Mutant_Emi("Mutant_Emi", 2D) = "white" {}
		_Mutant_Spe("Mutant_Spe", 2D) = "white" {}
		_Mutant_diffuse("Mutant_diffuse", 2D) = "white" {}
		_T_Stone("T_Stone", 2D) = "white" {}
		_ChangeTex("ChangeTex", Range( -1 , 1)) = 1
		_NoiseTex("NoiseTex", 2D) = "white" {}
		_IcePower("IcePower", Float) = 1
		_IceIns("IceIns", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Mutant_normal;
		uniform float4 _Mutant_normal_ST;
		uniform sampler2D _Mutant_diffuse;
		uniform float4 _Mutant_diffuse_ST;
		uniform sampler2D _T_Stone;
		uniform float4 _T_Stone_ST;
		uniform sampler2D _NoiseTex;
		uniform float4 _NoiseTex_ST;
		uniform float _ChangeTex;
		uniform sampler2D _Mutant_Emi;
		uniform float4 _Mutant_Emi_ST;
		uniform float _IcePower;
		uniform float _IceIns;
		uniform sampler2D _Mutant_Spe;
		uniform float4 _Mutant_Spe_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Mutant_normal = i.uv_texcoord * _Mutant_normal_ST.xy + _Mutant_normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Mutant_normal, uv_Mutant_normal ) );
			float2 uv_Mutant_diffuse = i.uv_texcoord * _Mutant_diffuse_ST.xy + _Mutant_diffuse_ST.zw;
			float2 uv_T_Stone = i.uv_texcoord * _T_Stone_ST.xy + _T_Stone_ST.zw;
			float4 tex2DNode5 = tex2D( _T_Stone, uv_T_Stone );
			float2 uv_NoiseTex = i.uv_texcoord * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			float4 lerpResult6 = lerp( tex2D( _Mutant_diffuse, uv_Mutant_diffuse ) , tex2DNode5 , saturate( ( ( pow( tex2D( _NoiseTex, uv_NoiseTex ).r , 3.0 ) * 2.0 ) + _ChangeTex ) ));
			o.Albedo = lerpResult6.rgb;
			float2 uv_Mutant_Emi = i.uv_texcoord * _Mutant_Emi_ST.xy + _Mutant_Emi_ST.zw;
			float4 tex2DNode2 = tex2D( _Mutant_Emi, uv_Mutant_Emi );
			float4 lerpResult25 = lerp( tex2DNode2 , ( saturate( ( pow( tex2DNode5.r , _IcePower ) * _IceIns ) ) + tex2DNode2 ) , saturate( _ChangeTex ));
			o.Emission = lerpResult25.rgb;
			float2 uv_Mutant_Spe = i.uv_texcoord * _Mutant_Spe_ST.xy + _Mutant_Spe_ST.zw;
			o.Metallic = tex2D( _Mutant_Spe, uv_Mutant_Spe ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
406;197;1786;1102;686.08;725.1516;1.13278;True;False
Node;AmplifyShaderEditor.CommentaryNode;26;-485.1566,-1086.826;Float;False;1035.515;866.053;Comment;9;5;8;17;4;18;6;7;31;32;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-285.077,42.16406;Float;False;Property;_IcePower;IcePower;8;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;27;-148.5378,-172.4069;Float;False;1077.582;565.831;Comment;8;19;21;2;23;24;29;30;25;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;8;-435.1566,-568.8493;Float;True;Property;_NoiseTex;NoiseTex;7;0;Create;True;0;0;False;0;3aabffbea1fbc61498ebe46c4d1a8918;3aabffbea1fbc61498ebe46c4d1a8918;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-170.2085,-809.4422;Float;True;Property;_T_Stone;T_Stone;5;0;Create;True;0;0;False;0;796440853cd24b34ea267cd0df9422fb;b03d5c1e83f823842b8e43f191932d15;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-118.4711,-575.6567;Float;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;67.42883,-571.7568;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;19;-98.53778,-102.4816;Float;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-6.919495,114.167;Float;False;Property;_IceIns;IceIns;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;31;-91.17119,-510.6566;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;170.5781,-104.7733;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;72.62886,-519.7565;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-387.4072,-336.7735;Float;False;Property;_ChangeTex;ChangeTex;6;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;444.0917,70.75823;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;224.9039,-517.3134;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;403.349,-131.2316;Float;True;Property;_Mutant_Emi;Mutant_Emi;2;0;Create;True;0;0;False;0;404e99a36d8d57a4fbe95876873d1e69;404e99a36d8d57a4fbe95876873d1e69;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;161.1628,-1047.227;Float;True;Property;_Mutant_diffuse;Mutant_diffuse;4;0;Create;True;0;0;False;0;57975ef3dc1c0ee4795a9c6ec1ed9527;57975ef3dc1c0ee4795a9c6ec1ed9527;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;18;369.9039,-522.1136;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;700.2136,89.89581;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;30;430.5398,154.3966;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;6;330.8589,-828.7004;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;432.2779,626.2233;Float;True;Property;_Mutant_normal;Mutant_normal;1;0;Create;True;0;0;False;0;87b7ebc1fb117ae409e8784a7ef0c172;87b7ebc1fb117ae409e8784a7ef0c172;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;438.3282,838.9989;Float;True;Property;_Mutant_Spe;Mutant_Spe;3;0;Create;True;0;0;False;0;bed08f1ad8a2e32449fccc26cd6155d8;bed08f1ad8a2e32449fccc26cd6155d8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;25;804.8162,-126.938;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1351.108,-201.0937;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Amplify Shader/SBS/30Week/CharcaterFX_ICe;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;5;1
WireConnection;19;1;28;0
WireConnection;31;0;8;1
WireConnection;31;1;33;0
WireConnection;21;0;19;0
WireConnection;21;1;29;0
WireConnection;32;0;31;0
WireConnection;32;1;34;0
WireConnection;23;0;21;0
WireConnection;17;0;32;0
WireConnection;17;1;7;0
WireConnection;18;0;17;0
WireConnection;24;0;23;0
WireConnection;24;1;2;0
WireConnection;30;0;7;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;6;2;18;0
WireConnection;25;0;2;0
WireConnection;25;1;24;0
WireConnection;25;2;30;0
WireConnection;0;0;6;0
WireConnection;0;1;1;0
WireConnection;0;2;25;0
WireConnection;0;3;3;0
ASEEND*/
//CHKSM=37F235566E691092AFDAE37D480D53A0F01FBA3D