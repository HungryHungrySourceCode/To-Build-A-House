// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Hidden/Parallax" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Heightmap("Height map", 2D) = "white" {}
		_Main("Main", 2D) = "white" {}
		[NoScaleOffset]_Normal("Normal", 2D) = "white" {}
		[Header (Variables)]_Dispacment("Dispacment", float) = 0.015
		_TimePreview("TimePreview", float) = 0
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
		#pragma surface surf Standard vertex:vert addshadow fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		sampler2D _Heightmap;
		sampler2D _Main;
		sampler2D _Normal;
		float _Dispacment;
		float _TimePreview;
		float _Var2;
		float2 _p0_pi0_nc0_o2;
		float3 _p0_pi0_nc1_o4;
		float4 _p0_pi0_nc5_o3;
		float _p0_pi0_nc6_o1;
		float _p0_pi0_nc10_o0;
		float3 _p0_pi0_nc11_o6;
		float2 _p0_pi0_nc13_o0;
		float _p0_pi0_nc14_o0;
		float _p0_pi0_nc15_o0;
		float _p0_pi0_nc16_o2;
		float2 _p0_pi0_nc17_o5;
		float _p0_pi0_nc18_o0;
		float2 _p0_pi0_nc19_o2;

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
			float2 uv_Heightmap;
			float2 uv_Main;
			float4 position;
			float3 parallaxCord;

			INTERNAL_DATA
		};

		float2 CalculateParallaxUV(Input IN, float disp, sampler2D displacmentMap, float2 uv){
			float height = disp * (-0.5 + tex2D(displacmentMap, uv).x); 
			float2 texCoordOffsets = clamp(height * IN.parallaxCord.xy / IN.parallaxCord.z, -0.01f, 0.01f);  
			return uv + texCoordOffsets;
		}

		void vert (inout appdata v, out Input IN){
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN.position = UnityObjectToClipPos(v.vertex);
			float4x4 modelMatrixInverse = unity_WorldToObject;
			float3 binormal = cross(v.normal, v.tangent.xyz) * v.tangent.w;
			float3 viewDirInObjectCoords = mul(modelMatrixInverse, float4(_WorldSpaceCameraPos, 1.0)).xyz - v.vertex.xyz;
			float3x3 localSurface2ScaledObjectT = float3x3(v.tangent.xyz, binormal, v.normal);
			IN.parallaxCord = mul(localSurface2ScaledObjectT, viewDirInObjectCoords);
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			_p0_pi0_nc10_o0 = _Dispacment;
			_p0_pi0_nc13_o0 = IN.uv_Heightmap;
			_p0_pi0_nc14_o0 = _TimePreview;
			_p0_pi0_nc18_o0 = 0;
			_p0_pi0_nc15_o0 = _Var2;
			_p0_pi0_nc16_o2 = (_p0_pi0_nc14_o0 * _p0_pi0_nc15_o0);
			_p0_pi0_nc17_o5 = float2(_p0_pi0_nc16_o2, _p0_pi0_nc18_o0);
			_p0_pi0_nc19_o2 = (_p0_pi0_nc13_o0 + _p0_pi0_nc17_o5);
			_p0_pi0_nc0_o2 = CalculateParallaxUV(IN, _p0_pi0_nc10_o0, _Heightmap, _p0_pi0_nc19_o2);
			_p0_pi0_nc11_o6 = UnpackNormal(tex2D(_Normal, _p0_pi0_nc0_o2));
			_p0_pi0_nc5_o3 = tex2D(_Heightmap, _p0_pi0_nc0_o2);
			_p0_pi0_nc1_o4 = tex2D(_Main, _p0_pi0_nc0_o2).rgb;
			_p0_pi0_nc6_o1 = (_p0_pi0_nc5_o3).x;
			o.Albedo = _p0_pi0_nc1_o4;
			o.Occlusion = _p0_pi0_nc6_o1;
			o.Normal = _p0_pi0_nc11_o6;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
