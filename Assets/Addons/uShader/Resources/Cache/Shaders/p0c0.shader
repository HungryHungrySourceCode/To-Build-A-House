Shader "Hidden/uSE/Cache/p0c0" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[Header (Textures and Bumpmaps)]_Main("Main", 2D) = "white" {}
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
		}

		Cull Off
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf Standard addshadow 
		#include "UnityCG.cginc"
		#pragma target 4.0

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		sampler2D _Main;
		float4 _p0_pi0_nc0_o3;
		float3 _p0_pi0_nc0_o4;
		float _p0_pi0_nc0_o5;
		float3 _p0_pi0_nc0_o6;

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
			float2 uv_Main;
			float4 position;

			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc0_o3 = tex2D(_Main, IN.uv_Main);
			_p0_pi0_nc0_o4 = tex2D(_Main, IN.uv_Main).rgb;
			_p0_pi0_nc0_o5 = tex2D(_Main, IN.uv_Main).a;
			_p0_pi0_nc0_o6 = UnpackNormal(tex2D(_Main, IN.uv_Main));
			o.Albedo = (_p0_pi0_nc0_o3).rgb;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
