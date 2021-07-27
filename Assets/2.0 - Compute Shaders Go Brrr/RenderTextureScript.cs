using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RenderTextureScript: MonoBehaviour {

    [SerializeField]
    private ComputeShader _shader;
    [SerializeField]
    private int _size = 256;
    [SerializeField]
    private int _particleCount = 64;

    private Renderer _renderer;
    private RenderTexture _texture;
    private ComputeBuffer _buffer;

    /*
        Defines an C# equivalent representation of the particles for 
        initialization. The struct is memory-copied into its counterpart in the
        shader code, making the specific type of members not as important as
        long as the structs share an equivalent memory representation.      
    */
    struct Particle {
        Vector2 pos;
        Vector2 dir;
    }

    void Awake() {
        _texture = new RenderTexture(_size, _size, 24); // 24 for depth of RGBA

        /*
            Required in order to provide random access and to pass texture
            from the shader to this texture.          
        */      
        _texture.enableRandomWrite = true;
        _texture.Create();

        _renderer = GetComponent<Renderer>();
        _renderer.material.SetTexture("_MainTex", _texture);

        /*
            Round up to nearest multiple of 16, which is the thread count for
            out compute shader. This circumvent the need for boundary check when
            referencing the buffer from the shader code.
        */
        if (_particleCount % 16 != 0) {
            _particleCount = _particleCount / 16 + 1;
        }

        _buffer = new ComputeBuffer(
            _particleCount,
            sizeof(float) * 4,
            ComputeBufferType.Default
        );
        }

    void Update() {
        int kernel = _shader.FindKernel("ClearBoard");

        _shader.SetTexture(kernel, "Result", _texture);
        _shader.Dispatch(kernel, _size / 8, _size / 8, 1);


    }

    void OnDestroy() {
        _texture.Release();
        _buffer.Release();
    }
}
