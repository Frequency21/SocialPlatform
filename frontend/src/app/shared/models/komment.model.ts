import { Ertekeles } from './ertekeles.model';
export interface Komment {
  idopont: string;
  komment_iro_id: number;
  poszt_felh_id: number;
  poszt_idopont: string;
  szoveg: string;
  ertekeles: Ertekeles;
  isPublic: boolean;
}
