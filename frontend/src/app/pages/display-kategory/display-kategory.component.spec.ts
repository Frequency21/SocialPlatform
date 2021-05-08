import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DisplayKategoryComponent } from './display-kategory.component';

describe('DisplayKategoryComponent', () => {
  let component: DisplayKategoryComponent;
  let fixture: ComponentFixture<DisplayKategoryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DisplayKategoryComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DisplayKategoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
