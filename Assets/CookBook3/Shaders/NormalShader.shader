﻿Shader "Custom/NormalShader" {
	Properties {
		_MainTint("Diffuse Tint",Color) = (0,1,0,1)
		_NormalTex("Normal Map",2D) = "bump" {}
		_NormalMapIntensity("Normal intensity",Range(0,3)) = 1
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		//Link the property to the CG program
		sampler2D _NormalTex;
     	float4 _MainTint;
		float _NormalMapIntensity;

		//Make sure you get the UVs for the texture in the struct
		struct Input {
			float2 uv_NormalTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			//Use the tint provided as the base color for the material
			o.Albedo = _MainTint;

			//Get the normal data out of the normal map texture
			//using the UnpackNormal function
			float3 normalMap = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));

			normalMap.x *= _NormalMapIntensity;
			normalMap.y *= _NormalMapIntensity;

			//Apply the new normal to the lighting model
			o.Normal = normalize(normalMap.rgb);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
