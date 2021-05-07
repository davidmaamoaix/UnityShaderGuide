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
        
        /*
            This directive specifies the name of the main surface shader
            function, as well as the light model and other optional parameters.
            The syntax is:
            '#pragma surface <shaderFuncName> <lightModel> [optionalParams]'
            
            Optional parameters won't be covered in this example; more
            information on them can be found at:
            https://docs.unity3d.com/Manual/SL-SurfaceShaders.html
        */
        #pragma surface surf Standard
        
        /*
            Specifies a shader model. Most examples of this guide uses 3.0.
        */
        #pragma target 3.0
        
        /*
            Define the input structure here. Unity will automatically populate
            the variables based on given hints (covered in Example 1.1).
        */
        struct Input {
        
            // currently unused
            float2 uv_MainTex;
        };
        
        /*
            The function containing the shader code. It should always have the
            parameters (Input, inout SurfaceOutput) and return type 'void'.
            
            'Input' is the type you just defined.
            'SurfaceOutput' is an output structure. Choose one or write your
            own by following:
            https://docs.unity3d.com/Manual/SL-SurfaceShaderLighting.html
        */
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
            
            /*
                Packing the color values into one tensor, and pass to the output
                variable.
            */
            fixed4 color = fixed4(red, green, blue, 1);
            
            /*
                'SurfaceOutputStandard.Albedo' refers to the color of the
                material. See a complete list of properties (as well as other
                lighting models) here:
                https://docs.unity3d.com/Manual/SL-SurfaceShaders.html
            */
            o.Albedo = color.rgb;
        }
        
        ENDCG
    }
    
    /*
        Fallback shader in case no declared SubShader is supported by the
        device.
    */
    FallBack "Diffuse"
}
