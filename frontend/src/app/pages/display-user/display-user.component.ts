import { ModalPosztComponent } from './../modal-poszt/modal-poszt.component';
import { MatDialog } from '@angular/material/dialog';
import { UserService } from 'src/app/services/user.service';
import { User } from './../../shared/models/user.model';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-display-user',
  templateUrl: './display-user.component.html',
  styleUrls: ['./display-user.component.scss']
})
export class DisplayUserComponent implements OnInit {

  user?: User[];
  is?: boolean;

  constructor(
    private _Activatedroute: ActivatedRoute,
    private userService: UserService,
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
    this._Activatedroute.paramMap.subscribe(params => {
      this.getUser(Number(params.get("id")));
    });
  }

  getUser(id: number): void {
    this.userService.getUserByID(id).subscribe(user => {
      this.user = user;
      console.log(this.user);
    });
    this.is = true;
  }

  getDate(): number {
    if (!this.user) return 0;
    return Date.parse(this.user[0].csatl);
  }

  openDialog(){

    const dialogRef = this.dialog.open(ModalPosztComponent, {
      width: '40%',
      data: {szerzo_id : undefined, szerzo_nev: "", szerzo_profilkep: "", csoport_id:undefined, felhasznalo_id:undefined}
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }
}
