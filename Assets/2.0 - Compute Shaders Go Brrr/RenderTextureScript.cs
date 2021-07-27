using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RenderTextureScript: MonoBehaviour {

    [SerializeField]
    private ComputeShader _shader;
    [SerializeField]
    private int _size = 128;
    [SerializeField]
    private int _particleCount = 64;

    private Renderer _renderer;
    private RenderTexture _texture;
    private ComputeBuffer _buffer;

    private int _kernelClear;
    private int _kernelParticle;

    /*
        Defines an C# equivalent representation of the particles for 
        initialization. The struct is memory-copied into its counterpart in the
        shader code, making the specific type of members not as important as
        long as the structs share an equivalent memory representation.      
    */
    struct Particle {
        public Vector2 pos;
        public Vector2 dir;
    }

    void Awake() {
        _texture = new RenderTexture(_size, _size, 24) { // 24 for depth of RGBA

            /*
                Required in order to provide random access and to pass texture
                from the shader to this texture.          
            */
            enableRandomWrite = true
        };
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

        /*
            Initializing the buffer for the shader.
        */
        _buffer = new ComputeBuffer(
            _particleCount,
            sizeof(float) * 4,
            ComputeBufferType.Default
        );

        /*
            Get kernel ID from shader. Each kernel ID corresponds to a shader
            function.          
        */
        _kernelClear = _shader.FindKernel("ClearBoard");
        _kernelParticle = _shader.FindKernel("RunParticle");

        Init();
    }

    void Update() { 

        /*
            Updates the global shader variable 'DeltaTime' as it is different
            every frame.          
        */
        _shader.SetFloat("DeltaTime", Time.deltaTime);

        /*
            Dispatches the product of the parameters thread group, each offset
            by the geometric grid location.          
        */
        _shader.Dispatch(_kernelClear, _size / 8, _size / 8, 1);

        /*
            Same as above. Note the single dimension of this dispatch statement.
        */
        _shader.Dispatch(_kernelParticle, _particleCount / 16, 1, 1);
    }

    void OnDestroy() {

        /*
            Releases the allocated buffer and texture.
        */
        _texture.Release();
        _buffer.Release();
    }

    /*
        Initializes the particles and stores them in the buffer.
    */
    private void Init() {

        /*
            Creates an array object as the content of the buffer.
        */
        Particle[] particles = new Particle[_particleCount];

        for (int i = 0; i < particles.Length; i++) {

            /*
                Assigns each particle with an initial velocity and position.
            */
            float maxSpeed = _size * 0.2F;

            Particle particle = new Particle() {
                pos = new Vector2(
                    Random.Range(0, _size),
                    Random.Range(0, _size)
                ),
                dir = new Vector2(
                    Random.Range(-maxSpeed, maxSpeed),
                    Random.Range(-maxSpeed, maxSpeed)
                )
            };

            particles[i] = particle;
        }

        /*
            Some global attributes are consistent throughout the entire lifetime
            of the shader, so we are setting them once here.          
        */
        _buffer.SetData(particles);

        _shader.SetInt("BoardSize", _size);
        _shader.SetTexture(_kernelClear, "Result", _texture);

        _shader.SetTexture(_kernelParticle, "Result", _texture);
        _shader.SetBuffer(_kernelParticle, "ParticleBuffer", _buffer);
    }
}
