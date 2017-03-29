class Rectangle {
  PVector position;
  float wid; 
  float hei;
  color colore = color(0);
  
  public Rectangle(PVector position, float wid, float hei) {
    this.position = position.copy();
    this.wid = wid;
    this.hei = hei;
  }
  
  void setColore(color c) {
    colore = c;
  }
  
  void setH(float h) {
    this.hei = h;
  }
  void show() {
    noStroke();
    fill(colore);
    rect(position.x, position.y, wid, this.hei);
  }
}