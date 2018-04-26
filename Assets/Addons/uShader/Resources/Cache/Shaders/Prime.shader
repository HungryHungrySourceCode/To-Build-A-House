Shader "Hidden/uSE/Cache/Prime" { 
	Properties { 
		_Time_ ("Time", Vector) = (0,0,0,0)
		_SinTime_ ("SinTime", Vector) = (0,0,0,0)
		_CosTime_ ("CosTime", Vector) = (0,0,0,0)
		[Header (Textures and Bumpmaps)]_Texture("Texture", 2D) = "white" {}
	}
	SubShader {
		LOD 300
		Tags {
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
		}

		Fog {
			Mode Global
			Density 0
			Color (1, 1, 1, 1) 
			Range 0, 300
		}

		Stencil {
			Ref 0
			Comp Always
			Pass Keep
			Fail Keep
			ZFail Keep
		}

		Cull Off
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf Standard fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		float4 _Time_;
		float4 _SinTime_;
		float4 _CosTime_;
		sampler2D _Texture;
		float2 _p0_pi0_nc0_o0;
		float2 _p0_pi0_nc7_o2;
		float2 _p0_pi0_nc8_o2;
		float _p0_pi0_nc9_o1;
		float _p0_pi0_nc9_o2;
		float _p0_pi0_nc10_o2;
		float _p0_pi0_nc12_o0;
		float3 _p0_pi0_nc13_o4;
		float _p0_pi0_nc14_o0;

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
			float2 uv_Texture;
			float4 position;

			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc0_o0 = IN.uv_Texture;
			_p0_pi0_nc14_o0 = _Time_.x;
			_p0_pi0_nc7_o2 = (_p0_pi0_nc0_o0 + _p0_pi0_nc14_o0);
			_p0_pi0_nc12_o0 = 50;
			_p0_pi0_nc9_o2 = (_p0_pi0_nc7_o2).y;
			_p0_pi0_nc10_o2 = (_p0_pi0_nc9_o2 * _p0_pi0_nc12_o0);
			_p0_pi0_nc9_o1 = (_p0_pi0_nc7_o2).x;
			_p0_pi0_nc8_o2 = float2(_p0_pi0_nc9_o1, _p0_pi0_nc10_o2);
			_p0_pi0_nc13_o4 = tex2D(_Texture, _p0_pi0_nc8_o2).rgb;
			o.Albedo = _p0_pi0_nc13_o4;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
