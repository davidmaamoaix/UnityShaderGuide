Shader "Surface/GlossyShader" {

    Properties {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _CubeMap("Cube Map", CUBE) = "" {}
    }
    
    SubShader {
    
        Tags {
            "RenderType" = "Opaque"
        }
        
        LOD 200

        CGPROGRAM
        
        #pragma surface surf Standard
        #pragma target 3.0

        struct Input {
            float2 uv_MainTex;
            float3 worldRefl;
        };
        
        sampler2D _MainTex;
        samplerCUBE _CubeMap;

        void surf(Input data, inout SurfaceOutputStandard o) {
            o.Albedo = tex2D(_MainTex, data.uv_MainTex) / 6;
            o.Emission = texCUBE(_CubeMap, data.worldRefl).rgb;
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}
