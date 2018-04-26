// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/NewShader" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Tooonseed("Tooon seed", 2D) = "white" {}
		_Main("Main", 2D) = "white" {}
		_TimePreview("Time sim", float) = 0
		[NoScaleOffset]_BRDF("BRDF", 2D) = "black" {}
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
		#pragma surface surf USShader vertex:vert addshadow fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		sampler2D _Tooonseed;
		sampler2D _Main;
		sampler2D _BRDF;
		float _TimePreview;
		float3 _p0_pi0_nc1_o4;
		float3 _p0_pi0_nc5_o2;
		float _p0_pi0_nc6_o0;
		float4 _p0_pi1_nc0_o0;
		float4 _p0_pi1_nc9_o0;
		float4 _p0_pi1_nc10_o2;

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
			float2 uv_Tooonseed;
			float2 uv_Main;
			float4 position;

			INTERNAL_DATA
		};

		inline float4 LightingUSShader (SurfaceOutput o, fixed3 lightDir, half3 viewDir, fixed atten){
			_p0_pi1_nc0_o0 = float4(o.Albedo * _LightColor0.rgb * tex2D (_Tooonseed, float2(dot (o.Normal, lightDir) * 0.5+ _TimePreview.x/4, 0.5)).rgb * (atten * 4), 1.0f);
			_p0_pi1_nc9_o0 = float4(( o.Albedo * _LightColor0.rgb * tex2D(_BRDF, float2(max( 0.5, dot(o.Normal, lightDir) ), 1 - pow( clamp(1.0 - dot ( normalize( lightDir + viewDir ), normalize(o.Normal) ), 0.0, 1.0), 0.66 )) ).rgb + _LightColor0.rgb * float4(1, 1, 1, 1) .rgb * pow( max( 0, dot(o.Normal, normalize( lightDir + viewDir )) ), o.Specular * 8.0) * o.Gloss ) * atten * 2, 1);
			_p0_pi1_nc10_o2 = (_p0_pi1_nc0_o0 * _p0_pi1_nc9_o0);
			float4 outputCol;
			outputCol = _p0_pi1_nc10_o2;
			return outputCol;
		}
		float Posterize(float chanel, int steps)
		{
			if(steps < 1)
				steps = 255;
			float block = 1.0f/(float)steps;
			float result = 0;
			while(chanel > result + block)
			{
				   result += block;
			}
			return result;
		}

		void vert (inout appdata v, out Input IN){
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN.position = UnityObjectToClipPos(v.vertex);
		}

		void surf (Input IN, inout SurfaceOutput o) {
			_p0_pi0_nc1_o4 = tex2D(_Main, IN.uv_Tooonseed).rgb;
			_p0_pi0_nc6_o0 = 10;
			_p0_pi0_nc5_o2 = float3(Posterize(_p0_pi0_nc1_o4.r, _p0_pi0_nc6_o0), Posterize(_p0_pi0_nc1_o4.g, _p0_pi0_nc6_o0), Posterize(_p0_pi0_nc1_o4.b, _p0_pi0_nc6_o0));
			o.Albedo = _p0_pi0_nc5_o2;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
