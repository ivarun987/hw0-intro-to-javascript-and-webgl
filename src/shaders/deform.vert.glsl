#version 330

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;

uniform int u_Time;
uniform vec3 u_Camera;

in vec4 vs_Pos;
in vec4 vs_Nor;

out vec3 fs_Pos;
out vec3 fs_Nor;
out vec3 fs_LightVec;

void main()
{
    // TODO Homework 4
    fs_Nor = normalize(u_ModelInvTr * vec3(vs_Nor));
    vec4 modelposition = u_Model * vs_Pos;

    float t = sin(u_Time / 100.0);
    vec4 wavy_modelposition = modelposition +
                                vec4(sin(u_Time * modelposition.y / 100.0),
                                     sin(u_Time * 0.05),
                                     sin(modelposition.x * 0.2), 0);

    vec4 normalized = vec4(normalize(modelposition).xyz * 3, 1);
    modelposition = mix(modelposition, wavy_modelposition, t);
    modelposition = mix(modelposition, normalized, t);

    fs_LightVec = u_Camera - vec3(modelposition);
    fs_Pos = vec3(modelposition);

    gl_Position = u_Proj * u_View * modelposition;
}
