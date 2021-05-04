export interface User {
    id: number;
    email: string;
    vnev: string;
    knev: string;
    csatl: string;
    szul_dat: Date;
    munka_iskola?: string;
    picture?: Blob;
    isAdmin: boolean;
}

export interface Ismeros {
    felhasznalo1_id: number;
    felhasznalo2_id: number;
}


export interface Fenykepalbum {
    album_id: number;
    tulaj_id: number;
}

export interface Kategoria {
    nev: string;
    fenykepalbum_id: number;
}

export interface Fenykep {
    kep_id: number;
    kep: Blob;
    nev: string;
    kategoria_id: string;
}