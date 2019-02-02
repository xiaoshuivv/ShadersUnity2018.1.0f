Shader "Custom/SimpleLambert" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
	
		#pragma surface surf SimpleLambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		//Allows us to use the  SimpleLambert lighting mode  
		half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten)
		{
			//First calculate the dot product of the light direction and the surface's normal
			half NdotL = dot(s.Normal, lightDir);
			//Next,set what color should be returned 
			half4 color;
			color.rgb = s.Albedo * _LightColor0.rgb  * (NdotL * atten);
			color.a = s.Alpha;
			//Return the calculated color
			return color;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
