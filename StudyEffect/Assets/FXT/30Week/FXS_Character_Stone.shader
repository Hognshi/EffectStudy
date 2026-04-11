// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amplify Shader/SBS/30Week/CharcaterFX_Stone"
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
		uniform sampler2D _Mutant_Spe;
		uniform float4 _Mutant_Spe_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Mutant_normal = i.uv_texcoord * _Mutant_normal_ST.xy + _Mutant_normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Mutant_normal, uv_Mutant_normal ) );
			float2 uv_Mutant_diffuse = i.uv_texcoord * _Mutant_diffuse_ST.xy + _Mutant_diffuse_ST.zw;
			float2 uv_T_Stone = i.uv_texcoord * _T_Stone_ST.xy + _T_Stone_ST.zw;
			float2 uv_NoiseTex = i.uv_texcoord * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
			float4 lerpResult6 = lerp( tex2D( _Mutant_diffuse, uv_Mutant_diffuse ) , tex2D( _T_Stone, uv_T_Stone ) , saturate( ( tex2D( _NoiseTex, uv_NoiseTex ).r + _ChangeTex ) ));
			o.Albedo = lerpResult6.rgb;
			float2 uv_Mutant_Emi = i.uv_texcoord * _Mutant_Emi_ST.xy + _Mutant_Emi_ST.zw;
			o.Emission = tex2D( _Mutant_Emi, uv_Mutant_Emi ).rgb;
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
290;1089;1786;1120;1437.169;712.447;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;7;-508.2787,80.78262;Float;False;Property;_ChangeTex;ChangeTex;6;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-556.0281,-151.293;Float;True;Property;_NoiseTex;NoiseTex;7;0;Create;True;0;0;False;0;3aabffbea1fbc61498ebe46c4d1a8918;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-189.7676,-121.857;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-527.8087,-619.2698;Float;True;Property;_Mutant_diffuse;Mutant_diffuse;4;0;Create;True;0;0;False;0;57975ef3dc1c0ee4795a9c6ec1ed9527;57975ef3dc1c0ee4795a9c6ec1ed9527;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-540.6801,-382.786;Float;True;Property;_T_Stone;T_Stone;5;0;Create;True;0;0;False;0;b03d5c1e83f823842b8e43f191932d15;b03d5c1e83f823842b8e43f191932d15;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;18;-31.76758,-131.857;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-586.9203,1405.973;Float;True;Property;_Mutant_Spe;Mutant_Spe;3;0;Create;True;0;0;False;0;bed08f1ad8a2e32449fccc26cd6155d8;bed08f1ad8a2e32449fccc26cd6155d8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-592.9706,1193.197;Float;True;Property;_Mutant_normal;Mutant_normal;1;0;Create;True;0;0;False;0;87b7ebc1fb117ae409e8784a7ef0c172;87b7ebc1fb117ae409e8784a7ef0c172;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-576.0831,967.8669;Float;True;Property;_Mutant_Emi;Mutant_Emi;2;0;Create;True;0;0;False;0;404e99a36d8d57a4fbe95876873d1e69;404e99a36d8d57a4fbe95876873d1e69;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;6;164.4871,-377.3444;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;622.0498,-321.6399;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Amplify Shader/SBS/30Week/CharcaterFX_Stone;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Custom;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;0;8;1
WireConnection;17;1;7;0
WireConnection;18;0;17;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;6;2;18;0
WireConnection;0;0;6;0
WireConnection;0;1;1;0
WireConnection;0;2;2;0
WireConnection;0;3;3;0
ASEEND*/
//CHKSM=30E8E335B10B6EC6B64630653512702D1C155381