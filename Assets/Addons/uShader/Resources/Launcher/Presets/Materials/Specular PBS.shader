// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Specular PBS" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Main("Main", 2D) = "white" {}
		_Normal("Normal", 2D) = "white" {}
		[NoScaleOffset]_Specular("Specular", 2D) = "white" {}
		[NoScaleOffset]_Occlusion("Occlusion", 2D) = "white" {}
		[NoScaleOffset]_Emission("Emission", 2D) = "white" {}
		[Header (Colors)]_MainTint("Main Tint", Color) = (0.204192,0.6980392,0.04705881,1)
		_SpecularTint("Specular Tint", Color) = (0.2929841,0.2076124,0.4411765,0.728)
		[Header (Variables)]_TimePreview("TimePreview", float) = 0
		_Var2("Var2", float) = 0.1
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

		Cull Back
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf StandardSpecular alpha vertex:vert addshadow fullforwardshadows 
		#pragma target 3.0
		#include "UnityCG.cginc"

		sampler2D _Main;
		sampler2D _Normal;
		sampler2D _Specular;
		sampler2D _Occlusion;
		sampler2D _Emission;
		float4 _MainTint;
		float4 _SpecularTint;
		float _TimePreview;
		float _Var2;
		float3 _p0_pi0_nc12_o4;
		float _p0_pi0_nc12_o5;
		float3 _p0_pi0_nc15_o4;
		float _p0_pi0_nc15_o5;
		float4 _p0_pi0_nc20_o3;
		float _p0_pi0_nc22_o1;
		float3 _p0_pi0_nc31_o1;
		float3 _p0_pi0_nc32_o2;
		float3 _p0_pi0_nc33_o1;
		float _p0_pi0_nc33_o2;
		float3 _p0_pi0_nc34_o2;
		float3 _p0_pi0_nc36_o6;
		float _p0_pi0_nc37_o2;
		float _p0_pi0_nc38_o0;
		float _p0_pi0_nc39_o0;
		float _p0_pi0_nc40_o2;
		float _p0_pi0_nc41_o0;
		float2 _p0_pi0_nc43_o5;
		float2 _p0_pi0_nc44_o0;
		float2 _p0_pi0_nc45_o2;

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

		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			_p0_pi0_nc12_o4 = tex2D(_Main, IN.uv_Main).rgb;
			_p0_pi0_nc12_o5 = tex2D(_Main, IN.uv_Main).a;
			_p0_pi0_nc15_o4 = tex2D(_Specular, IN.uv_Main).rgb;
			_p0_pi0_nc15_o5 = tex2D(_Specular, IN.uv_Main).a;
			_p0_pi0_nc20_o3 = tex2D(_Occlusion, IN.uv_Main);
			_p0_pi0_nc22_o1 = (_p0_pi0_nc20_o3).x;
			_p0_pi0_nc31_o1 = _MainTint.rgb;
			_p0_pi0_nc32_o2 = (_p0_pi0_nc31_o1 * _p0_pi0_nc12_o4);
			_p0_pi0_nc33_o1 = _SpecularTint.rgb;
			_p0_pi0_nc33_o2 = _SpecularTint.a;
			_p0_pi0_nc34_o2 = (_p0_pi0_nc33_o1 * _p0_pi0_nc15_o4);
			_p0_pi0_nc38_o0 = _TimePreview;
			_p0_pi0_nc37_o2 = (_p0_pi0_nc33_o2 * _p0_pi0_nc15_o5);
			_p0_pi0_nc39_o0 = _Var2;
			_p0_pi0_nc40_o2 = (_p0_pi0_nc38_o0 * _p0_pi0_nc39_o0);
			_p0_pi0_nc41_o0 = 0;
			_p0_pi0_nc43_o5 = float2(_p0_pi0_nc40_o2, _p0_pi0_nc41_o0);
			_p0_pi0_nc44_o0 = IN.uv_Main;
			_p0_pi0_nc45_o2 = (_p0_pi0_nc44_o0 + _p0_pi0_nc43_o5);
			_p0_pi0_nc36_o6 = UnpackNormal(tex2D(_Normal, _p0_pi0_nc45_o2));
			o.Albedo = _p0_pi0_nc32_o2;
			o.Normal = _p0_pi0_nc36_o6;
			o.Smoothness = _p0_pi0_nc37_o2;
			o.Occlusion = _p0_pi0_nc22_o1;
			o.Alpha = _p0_pi0_nc12_o5;
			o.Specular = _p0_pi0_nc34_o2;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
