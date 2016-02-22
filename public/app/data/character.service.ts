import {Injectable} from 'angular2/core';

import {Observable} from 'rxjs/Observable';

import {VisualTalesHttpService, IPose} from './data';

@Injectable()
export class CharacterService {
  constructor(private _visualTalesHttp:VisualTalesHttpService<ICharacter>) {
    _visualTalesHttp.setUrl('characters');
  }
  
  getCharacter(id:number):Observable<ICharacter>{
    return this._visualTalesHttp.get(id); 
  }
  
  updateCharacter(payload:any):Observable<ICharacter>{
    return this._visualTalesHttp.update(payload);
  }
  
  deleteCharacter(id:number):Observable<{}>{
    return this._visualTalesHttp.delete(id);
  }
  
  getPosesForCharacter(id:number):Observable<IPose[]>{
    return this._visualTalesHttp.getChildren<IPose>(id, 'poses');
  }
  
  addPoseToCharacter(id:number, pose:IPose):Observable<IPose>{
    return this._visualTalesHttp.createChild<IPose>(id, 'poses', pose);
  }
}

export interface ICharacter{
  id?:number;
  name:string;
  description?:string;
}