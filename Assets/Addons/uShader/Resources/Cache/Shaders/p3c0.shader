Shader "Hidden/uSE/Cache/p3c0" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[Header (Textures and Bumpmaps)]_Front("Front", 2D) = "white" {}
		_Back("Back", 2D) = "white" {}
		[Header (Colors)]_Color("Color", Color) = (1,1,1,1)
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
		}

		Cull Front
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf Standard addshadow 
		#include "UnityCG.cginc"
		#pragma target 4.0

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		sampler2D _Front;
		sampler2D _Back;
		float4 _Color;
		float3 _p1_pi0_nc1_o4;
		float _p1_pi0_nc1_o5;
		float4 _p1_pi2_nc1_o0;

		struct appdata{
			float4 vertex    : POSITION;  // The vertex position in model space.
			float3 normal    : NORMAL;    // The vertex normal in model space.
			float4 texcoord  : TEXCOORD0; // The first UV coordinate.
			float4 texcoord1 : TEXCOORD1; // The second UV coordinate.
			float4 texcoord2 : TEXCOORD2; // The third UV coordinate.
			float4 tangent   : TANGENT;   // The tangent vector in Model Space (used for normal mapping).
			float4 color     : COLOR;     // Per-vertex color.
		};

		struct Input{
			float2 texcoord : TEXCOORD0;
			float2 texcoord1 : TEXCOORD1;
			float2 uv_Front;
			float2 uv_Back;
			float4 color : COLOR;
			float4 position;

			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p1_pi0_nc1_o4 = tex2D(_Back, IN.uv_Front).rgb;
			_p1_pi0_nc1_o5 = tex2D(_Back, IN.uv_Front).a;
			o.Albedo = (_p1_pi0_nc1_o4).rgb;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
