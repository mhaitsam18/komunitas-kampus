<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Profil Anggota</h2>
                        <p class="text-white mb-2">Selamat datang di laman profil anggota</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <div class="p-lg-3">
                            <h4>Akun Kamu :</h4>
                            <div class="row mt-4">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-control-label">Nama</label>
                                        <input type="text" class="form-control" value="<?php echo $profil[0]->name ?>" readonly>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="form-control-label">Email</label>
                                        <input type="text" class="form-control" value="<?php echo $profil[0]->email ?>" readonly>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <h4>Kontak</h4>
                            <form>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label">Tempat Lahir</label>
                                            <input type="text" name="place_of_birth" class="form-control" value="<?php echo $profil[0]->place_of_birth ?>" readonly>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label">Tanggal Lahir</label>
                                            <input type="date" name="birthday" data-date-format="yyyy-mm-dd" class="form-control datepicker" value="<?php echo $profil[0]->birthday ?>" readonly>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label class="form-control-label">Handphone</label>
                                            <input type="number" name="phone_number" class="form-control" value="<?php echo $profil[0]->phone_number ?>" readonly>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label class="form-control-label">Alamat</label>
                                            <textarea rows="4" name="address" class="form-control" readonly><?php echo $profil[0]->address ?></textarea>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>