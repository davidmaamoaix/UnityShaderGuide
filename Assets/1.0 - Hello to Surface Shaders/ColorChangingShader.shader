/*
    The name and path of the shader. This changes the displayed name of
    this shader in the 'Shader' tab of a material. Adding slashes '/'
    enables grouping shaders into sub-directories.
*/
Shader "Surface/ColorChangingShader" {
    
    /*
        A 'SubShader' contains the shader code of your shader.
        The syntax here resembles a C-like language.
    */
    SubShader {
        
        /*
            The tag section contains properties of the current shader, such
            as how it should be rendered.
        */
        Tags {
        
            /*
                'Opaque' means the material is... well, opaque (as opposed to
                transparent).
            */
            "RenderType" = "Opaque"
        }
        
        LOD 200
        
        /*
           The 'CGPROGRAM' and 'ENDCG' directives mark the beginning and the
           end of the actual shader code, written in HLSL.
        */
        CGPROGRAM
        
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
        
        struct Input {
            float2 uv_MainTex;
        };

        void surf(Input data, inout SurfaceOutputStandard o) {
            
            /*
                '_Time' is a float4 variable storing the current time since
                level load.
                
                The 4 elements are (time / 20, time, time * 2, time * 3);
                
                A list of built-in variables can be found in the documentation:
                https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
            */
            fixed red = sin(_Time.y) / 2 + 0.5;
            fixed green = sin(_Time.y * 2) / 2 + 0.5;
            fixed blue = sin(_Time.y * 3) / 2 + 0.5;
            
            fixed4 color = fixed4(red, green, blue, 1);
            o.Albedo = color.rgb;
        }
        
        ENDCG
    }
    FallBack "Diffuse"
}
