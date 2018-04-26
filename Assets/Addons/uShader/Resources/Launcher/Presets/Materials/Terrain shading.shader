// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Hidden/Terrain sading" { 
	Properties { 
		[Header (Textures and Bumpmaps)]_Texture("Texture", 2D) = "white" {}
		_Texture2("Texture2", 2D) = "white" {}
		[NoScaleOffset]_Texture3("Texture3", 2D) = "white" {}
		[Header (CubeMaps)]_Cubemap("Cubemap", CUBE) = "" {}
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
		#pragma surface surf StandardSpecular vertex:vert addshadow fullforwardshadows 
		#pragma target 4.0
		#include "UnityCG.cginc"

		sampler2D _Texture;
		sampler2D _Texture2;
		sampler2D _Texture3;
		samplerCUBE _Cubemap;
		float _TimePreview;
		float _Var2;
		float3 _p0_pi0_nc0_o4;
		float3 _p0_pi0_nc1_o6;
		float3 _p0_pi0_nc2_o4;
		float _p0_pi0_nc3_o1;
		float3 _p0_pi0_nc10_o3;
		float3 _p0_pi0_nc11_o1;
		float3 _p0_pi0_nc12_o1;
		float _p0_pi0_nc13_o3;
		float _p0_pi0_nc15_o0;
		float _p0_pi0_nc16_o0;
		float2 _p0_pi0_nc17_o2;
		float _p0_pi0_nc20_o0;
		float3 _p0_pi0_nc22_o1;
		float2 _p0_pi0_nc23_o0;
		float _p0_pi0_nc24_o0;
		float _p0_pi0_nc25_o0;
		float _p0_pi0_nc26_o2;
		float2 _p0_pi0_nc27_o5;
		float _p0_pi0_nc28_o0;
		float2 _p0_pi0_nc30_o2;

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
			float2 uv_Texture2;
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

		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			_p0_pi0_nc20_o0 = 0.015;
			_p0_pi0_nc23_o0 = IN.uv_Texture;
			_p0_pi0_nc24_o0 = _TimePreview;
			_p0_pi0_nc28_o0 = 0;
			_p0_pi0_nc11_o1 = float4(0.1397059, 0.1397059, 0.1397059, 1).rgb;
			_p0_pi0_nc12_o1 = float4(0.5808823, 0.2477292, 0.2477292, 1).rgb;
			_p0_pi0_nc25_o0 = _Var2;
			_p0_pi0_nc15_o0 = 0.6;
			_p0_pi0_nc16_o0 = 0.2;
			_p0_pi0_nc26_o2 = (_p0_pi0_nc24_o0 * _p0_pi0_nc25_o0);
			_p0_pi0_nc27_o5 = float2(_p0_pi0_nc26_o2, _p0_pi0_nc28_o0);
			_p0_pi0_nc30_o2 = (_p0_pi0_nc23_o0 + _p0_pi0_nc27_o5);
			_p0_pi0_nc22_o1 = float4(0.007352948, 0.007352948, 0.007352948, 1).rgb;
			_p0_pi0_nc17_o2 = CalculateParallaxUV(IN, _p0_pi0_nc20_o0, _Texture3, _p0_pi0_nc30_o2);
			_p0_pi0_nc1_o6 = UnpackNormal(tex2D(_Texture2, _p0_pi0_nc17_o2));
			_p0_pi0_nc2_o4 = tex2D(_Texture3, _p0_pi0_nc17_o2).rgb;
			_p0_pi0_nc3_o1 = (_p0_pi0_nc2_o4).x;
			_p0_pi0_nc0_o4 = tex2D(_Texture, _p0_pi0_nc17_o2).rgb;
			_p0_pi0_nc13_o3 = lerp(_p0_pi0_nc16_o0, _p0_pi0_nc15_o0, _p0_pi0_nc3_o1);
			_p0_pi0_nc10_o3 = lerp(_p0_pi0_nc11_o1, _p0_pi0_nc12_o1, _p0_pi0_nc3_o1);
			o.Occlusion = _p0_pi0_nc3_o1;
			o.Albedo = _p0_pi0_nc0_o4;
			o.Normal = _p0_pi0_nc1_o6;
			o.Smoothness = _p0_pi0_nc13_o3;
			o.Specular = _p0_pi0_nc10_o3;
			o.Emission = _p0_pi0_nc22_o1;
		}
		ENDCG

	}
	FallBack "Diffuse"
}
