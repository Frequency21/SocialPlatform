import { CategoryService } from './../../services/category.service';
import { FormGroup, FormControl } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/services/user.service';
import { Subscription } from 'rxjs';
import { User } from 'src/app/shared/models/user.model';
import { Category } from 'src/app/shared/models/category.model';
import { MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-modal-kategory',
  templateUrl: './modal-kategory.component.html',
  styleUrls: ['./modal-kategory.component.scss']
})
export class ModalKategoryComponent implements OnInit {

  form: FormGroup = new FormGroup({
    nev: new FormControl()
  });

  subscription: Subscription;
  currentUser?: User;

  constructor(
    private userService: UserService,
    private categoryService: CategoryService,
    public dialogRef: MatDialogRef<ModalKategoryComponent>
  ) {
    this.subscription = this.userService.userSource.subscribe(user => this.currentUser = user);
  }

  ngOnInit(): void {
  }

  saveC(){
    var newC: Category = {
      nev: this.form.value.nev,
      felh_id: Number(this.currentUser?.id)
    };
    this.categoryService.saveCategory(newC).subscribe(ret => {
      console.log(ret);
    });
    this.onNoClick();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }


}
