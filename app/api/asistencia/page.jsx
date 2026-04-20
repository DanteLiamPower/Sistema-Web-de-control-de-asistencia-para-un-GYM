"use client";
import { useEffect, useState } from "react";

export default function Asistencia() {
    const [data, setData] = useState(null);

    const obtenerEstado = async () => {
        const res = await fetch("/api/asistencia");
        const json = await res.json();
        setData(json);
    };

    useEffect(() => {
        obtenerEstado();
        const interval = setInterval(obtenerEstado, 2000);
        return () => clearInterval(interval);
    }, []);

    return (
        <div className="p-4">
            <h1 className="text-xl font-bold">Control de Asistencia</h1>

            {data && (
                <div className="mt-4 bg-green-200 p-3 rounded">
                    <p>{data.mensaje}</p>
                    <p>{data.fecha}</p>
                </div>
            )}
        </div>
    );
}