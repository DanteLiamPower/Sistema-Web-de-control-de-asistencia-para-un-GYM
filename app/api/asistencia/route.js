/// esto de aqui es un endpoint para mandar 

let estado = {
    mensaje: "Sin registros"
};

export async function POST(request) {
    const data = await request.json();

    estado = {
        mensaje: `Entrada recibida de dispositivo`,
        fecha: new Date().toISOString(),
        dispositivo: data.dispositivo || "ESP32"
    };

    return Response.json({ ok: true });
}

export async function GET() {
    return Response.json(estado);
}