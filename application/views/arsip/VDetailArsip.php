<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Selamat datang di laman arsip komunitas</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header border-0">
                        <h4 class="mb-0"><?php echo $komunitas['nama'] ?></h4>
                        <p class="mb-0 mt-0"><small>Daftar arsip yang ada pada komunitas ini</small></p>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-items-center table-flush">
                            <thead class="thead-light">
                                <tr>
                                    <th class="text-center">Nama Arsip</th>
                                    <th class="text-center">Tgl Ditambahkan</th>
                                    <th class="text-center">Author</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($arsip) { ?>
                                    <?php foreach ($arsip as $a) { ?>
                                        <td class="text-center">
                                            <a href="<?php echo base_url() ?>assets/arsip/<?php echo $a->file ?>" class="text-default">
                                                <strong><?php echo $a->nama ?></strong>
                                            </a>
                                        </td>
                                        <td class="text-center"><?php echo date("l, d M Y H:s:i", strtotime($a->created_at)) ?></td>
                                        <td class="text-center"><?php echo $a->nama_user ?></td>
                                        <td class="text-center">
                                            <a href="<?php echo base_url() ?>assets/arsip/<?php echo $a->file ?>" class="badge badge-success">
                                                <i class="ni ni-button-play"></i>
                                            </a>
                                            <?php if ($cek_anggota->is_admin): ?>
                                                <a href="<?php echo base_url() ?>arsip/delete/<?php echo $a->id_komunitas ?>/<?php echo $a->id ?>" class="badge badge-danger">
                                                    <i class="ni ni-scissors"></i>
                                                </a>
                                            <?php endif ?>
                                        </td>
                                    <?php } ?>
                                <?php } else { ?>
                                    <tr>
                                        <td class="text-center" colspan="4">No Data Found</td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer py-4">
                        <?php if ($cek_anggota->is_admin): ?>
                            <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#exampleModal">
                                Tambah Arsip
                            </button>
                        <?php endif ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <form action="<?php echo base_url() ?>arsip/store" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id_komunitas" value="<?php echo $komunitas['id'] ?>">
                    <input type="hidden" name="token_komunitas" value="<?php echo $komunitas['token'] ?>">
                    <div class="form-group">
                        <label class="form-control-label">Nama Arsip</label>
                        <input type="text" name="nama" class="form-control" placeholder="Nama Arsip" required>
                    </div>
                    <div class="form-group">
                        <label class="form-control-label">Tipe Arsip</label>
                        <select name="tipe" class="form-control">
                            <option value="Vidio">Vidio</option>
                            <option value="Dokumen">Dokumen</option>
                            <option value="Spreadsheet">Spreadsheet</option>
                            <option value="Image">Image</option>
                            <option value="Image">Powerpoint</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-control-label">Pilih File</label>
                        <input type="file" name="file" class="form-control" required>
                    </div>
                    <input type="submit" name="submit" value="Masukan Arsip" class="btn btn-danger mt-5 btn-block">
                </form>
            </div>
        </div>
    </div>
</div>