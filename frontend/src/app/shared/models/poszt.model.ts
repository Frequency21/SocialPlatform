import { Ertekeles } from "./ertekeles.model";

export interface Poszt {
    idopont: string;
    szerzo_id: number;

    szerzo_nev: string;
    szerzo_profil_kep?: string;

    csoport_id: number;
    felhasznalo_id: number;
    szoveg: string;
    ertekeles: Ertekeles;
    isPublic: boolean,
}