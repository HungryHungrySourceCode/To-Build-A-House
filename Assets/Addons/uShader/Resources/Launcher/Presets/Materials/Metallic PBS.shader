// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Metallic PBS" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Main("Main", 2D) = "white" {}
		_Normal("Normal", 2D) = "white" {}
		[NoScaleOffset]_Specular("Specular", 2D) = "white" {}
		[Header (Variables)]_TimePreview("TimePreview", float) = 0
		_Var("Var", float) = 0.1
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
		#pragma surface surf Standard vertex:vert addshadow fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		sampler2D _Main;
		sampler2D _Normal;
		sampler2D _Specular;
		float _TimePreview;
		float _Var;
		float3 _p0_pi0_nc8_o6;
		float3 _p0_pi0_nc12_o4;
		float _p0_pi0_nc24_o0;
		float _p0_pi0_nc25_o0;
		float _p0_pi0_nc26_o0;
		float _p0_pi0_nc27_o0;
		float _p0_pi0_nc28_o2;
		float2 _p0_pi0_nc29_o0;
		float _p0_pi0_nc30_o0;
		float2 _p0_pi0_nc31_o5;
		float2 _p0_pi0_nc32_o2;

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
			float2 uv_Normal;
			float4 position;

			INTERNAL_DATA
		};

		void vert (inout appdata v, out Input IN){
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN.position = UnityObjectToClipPos(v.vertex);
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc29_o0 = IN.uv_Main;
			_p0_pi0_nc26_o0 = _TimePreview;
			_p0_pi0_nc24_o0 = 1;
			_p0_pi0_nc25_o0 = 0.7;
			_p0_pi0_nc27_o0 = _Var;
			_p0_pi0_nc28_o2 = (_p0_pi0_nc26_o0 * _p0_pi0_nc27_o0);
			_p0_pi0_nc30_o0 = 0;
			_p0_pi0_nc31_o5 = float2(_p0_pi0_nc28_o2, _p0_pi0_nc30_o0);
			_p0_pi0_nc32_o2 = (_p0_pi0_nc29_o0 + _p0_pi0_nc31_o5);
			_p0_pi0_nc12_o4 = tex2D(_Main, _p0_pi0_nc32_o2).rgb;
			_p0_pi0_nc8_o6 = UnpackNormal(tex2D(_Normal, _p0_pi0_nc32_o2));
			o.Albedo = _p0_pi0_nc12_o4;
			o.Normal = _p0_pi0_nc8_o6;
			o.Metallic = _p0_pi0_nc24_o0;
			o.Smoothness = _p0_pi0_nc25_o0;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
