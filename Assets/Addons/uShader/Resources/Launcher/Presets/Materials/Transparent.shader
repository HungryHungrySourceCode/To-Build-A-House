// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Transparent" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Texture("Texture", 2D) = "white" {}
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

		Cull Off
		ZWrite  On
		ColorMask   RGBA

		CGPROGRAM 
		#pragma surface surf Standard alpha vertex:vert addshadow fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		sampler2D _Texture;
		float _TimePreview;
		float _Var2;
		float3 _p0_pi0_nc1_o4;
		float _p0_pi0_nc1_o5;
		float _p0_pi0_nc4_o0;
		float _p0_pi0_nc5_o0;
		float _p0_pi0_nc6_o2;
		float2 _p0_pi0_nc7_o5;
		float _p0_pi0_nc8_o0;
		float2 _p0_pi0_nc9_o0;
		float2 _p0_pi0_nc11_o2;

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

		void vert (inout appdata v, out Input IN){
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN.position = UnityObjectToClipPos(v.vertex);
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc4_o0 = _TimePreview;
			_p0_pi0_nc9_o0 = IN.uv_Texture;
			_p0_pi0_nc5_o0 = _Var2;
			_p0_pi0_nc6_o2 = (_p0_pi0_nc4_o0 * _p0_pi0_nc5_o0);
			_p0_pi0_nc8_o0 = 0;
			_p0_pi0_nc7_o5 = float2(_p0_pi0_nc6_o2, _p0_pi0_nc8_o0);
			_p0_pi0_nc11_o2 = (_p0_pi0_nc9_o0 + _p0_pi0_nc7_o5);
			_p0_pi0_nc1_o5 = tex2D(_Texture, _p0_pi0_nc11_o2).a;
			_p0_pi0_nc1_o4 = tex2D(_Texture, _p0_pi0_nc11_o2).rgb;
			o.Alpha = _p0_pi0_nc1_o5;
			o.Albedo = _p0_pi0_nc1_o4;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
