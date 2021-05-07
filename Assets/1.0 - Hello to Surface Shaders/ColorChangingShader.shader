Shader "Surface/ColorChangingShader" {
    
    SubShader {
    
        Tags {
            "RenderType" = "Opaque"
        }
        
        LOD 200

        CGPROGRAM
        
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
        
        struct Input {
            float2 uv_MainTex;
        };

        void surf(Input data, inout SurfaceOutputStandard o) {
            
            fixed4 color = fixed4(1, 0, 0, 1);
            o.Albedo = color.rgb;
        }
        
        ENDCG
    }
    FallBack "Diffuse"
}
