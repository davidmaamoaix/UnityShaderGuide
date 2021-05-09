Shader "Surface/CelestialShader" {

    Properties {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Emission("Emission", Range(0, 1)) = 1
        _RollSpeed("Roll Speed", Float) = 0.5
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
            /*
                Obtains the position on screen for the current 'pixel' (as
                opposed to the texture UV, which we used before).
            */
            float4 screenPos;
        };
        
        sampler2D _MainTex;
        float _Emission;
        float _RollSpeed;

        void surf(Input data, inout SurfaceOutputStandard o) {
        
            /*
                The actual coordinate is obtained after division by 'w' due to
                the properties of homogenous coordinates.
            */
            float2 screenUV = data.screenPos.xy / data.screenPos.w;
            
            /*
                Offsets the UV by time to achieve a scrolling effect.
            */
            screenUV.x += _Time.x * _RollSpeed;
        
            /*
                Samples the texture, but with the screen-space UV.
            */
            float4 c = tex2D(_MainTex, screenUV);
            
            o.Albedo = c.rgb;
            
            /*
                Achieves a glowing effect.
                
                Note that emission doesn't create actual lighting; it merely
                make the surface look like its glowing by appearing bright.
            */
            o.Emission = c.rgb * _Emission;
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}
